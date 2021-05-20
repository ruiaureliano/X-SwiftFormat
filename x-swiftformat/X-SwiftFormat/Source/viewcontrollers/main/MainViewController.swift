import Cocoa

let kNoEnvironmentLabel = "Default Environment"

class MainViewController: NSViewController {

	@IBOutlet weak var appName: NSTextField!
	@IBOutlet weak var appVersion: NSTextField!
	@IBOutlet weak var appUpdateButton: NSButton!

	@IBOutlet weak var tabView: NSTabView!
	@IBOutlet weak var configurationTableView: NSTableView!
	@IBOutlet weak var rulesTableView: NSTableView!

	@IBOutlet weak var environmentPopUpButton: NSPopUpButton!
	@IBOutlet weak var environmentAdd: NSButton!
	@IBOutlet weak var environmentRemove: NSButton!
	@IBOutlet weak var versionButton: NSButton!
	@IBOutlet weak var resetButton: NSButton!
	@IBOutlet weak var previewButton: NSButton!

	private var effectiveAppearanceObservation: NSKeyValueObservation?
	var appUpdateVersionName: String?
	var appUpdateVersionButtonURL: String?

	var popover: NSPopover?

	var sharedConfiguration: SharedConfiguration = SharedConfiguration()

	override func viewDidLoad() {
		super.viewDidLoad()

		if let executable = Bundle.main.CFBundleExecutable {
			appName.stringValue = executable
		}

		if let version = Bundle.main.CFBundleShortVersionString, let build = Bundle.main.CFBundleVersion {
			appVersion.stringValue = "Version: \(version) (\(build))"
		}

		versionButton.title = " \(kSwiftFormatName)"

		Notifications.shared.observe(name: .didResignActive) { _ in
			DispatchQueue.main.async {
				self.popover?.close()
			}
		}

		Notifications.shared.observe(name: .environmentDidChanged) { sharedConfiguration in
			if let sharedConfiguration = sharedConfiguration as? SharedConfiguration {
				self.sharedConfiguration = sharedConfiguration
			}
		}

		Notifications.shared.observe(name: .environmentNeedsReload) { _ in
			self.reloadData()
		}

		Notifications.shared.observe(name: .readXSFFile) { payload in
			if let payload = payload as? [String: Any] {
				self.createConfiguration(with: payload)
			}
		}
		reloadData()
	}

	override func viewWillAppear() {
		super.viewWillAppear()
		checkUpdates()
		guard let window = self.view.window else { return }
		window.center()
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		guard let window = self.view.window else { return }
		window.isMovableByWindowBackground = true

		if SponsorsViewController.showSponsorWindow() {
			self.performSegue(withIdentifier: NSStoryboardSegue.Identifier("MAIN_TO_SPONSORS"), sender: nil)
		}
	}

	private func checkUpdates() {
		guard let url = URL(string: kXSwiftFormatReleases) else { return }

		let request = URLRequest(url: url)
		let task = URLSession.shared.dataTask(with: request) { data, _, _ in
			guard
				let data = data,
				var releases = data.json as? [[String: Any]]
			else {
				return
			}

			releases.sort { dictionary1, dictionary2 in
				let tagName1: String = dictionary1["tag_name"] as? String ?? ""
				let tagName2: String = dictionary2["tag_name"] as? String ?? ""
				return tagName1.compare(tagName2) != .orderedAscending
			}

			guard
				let release = releases.first,
				let name = release["name"] as? String,
				let tagName = release["tag_name"] as? String,
				let publishedAt = release["published_at"] as? String,
				let assets = release["assets"] as? [[String: Any]],
				let asset = assets.first,
				let browserDownloadURL = asset["browser_download_url"] as? String
			else {
				return
			}

			self.validateNewVersion(name: name, tagName: tagName, publishedAt: publishedAt, browserDownloadURL: browserDownloadURL)
		}
		task.resume()
	}

	private func validateNewVersion(name: String, tagName: String, publishedAt: String, browserDownloadURL: String) {
		if let version = Bundle.main.CFBundleShortVersionString {
			switch version.compare(tagName, options: .numeric, range: nil, locale: nil) {
			case .orderedAscending:
				DispatchQueue.main.async {
					self.appUpdateVersionName = name
					self.appUpdateVersionButtonURL = browserDownloadURL
					self.appUpdateButton.isEnabled = true
					self.appUpdateButton.isHidden = false
				}
			case .orderedSame:
				break
			case .orderedDescending:
				break
			}
		}
	}

	func reloadData() {
		DispatchQueue.main.async {
			self.sharedConfiguration = SharedConfiguration.loadConfiguration()
			self.environmentPopUpButton.removeAllItems()
			self.environmentPopUpButton.addItems(withTitles: self.sharedConfiguration.environments)
			var index: Int = 0
			for title in self.environmentPopUpButton.itemTitles {
				if title == self.sharedConfiguration.environment {
					self.environmentPopUpButton.selectItem(at: index)
					break
				}
				index += 1
			}
			self.environmentRemove.isEnabled = (self.sharedConfiguration.environment != kNoEnvironmentLabel)
			self.configurationTableView.reloadData()
			self.rulesTableView.reloadData()
		}
	}

	private func createConfiguration(with payload: [String: Any]) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			guard let window = NSApp.mainWindow else { return }

			let alert = NSAlert()
			alert.alertStyle = .informational
			alert.messageText = "Add Environment"
			alert.informativeText = ""
			alert.addButton(withTitle: "OK")
			alert.addButton(withTitle: "Cancel")
			let environmentName = NSTextField(frame: NSRect(x: 0, y: 0, width: 228, height: 24))
			environmentName.bezelStyle = .roundedBezel
			environmentName.placeholderString = "Environment name"
			alert.accessoryView = environmentName
			alert.beginSheetModal(for: window) { response in
				if response.rawValue == 1000 && environmentName.stringValue.count > 0 {
					self.sharedConfiguration.setConfiguration(configuration: payload, for: environmentName.stringValue)
				}
			}
		}
	}
}
