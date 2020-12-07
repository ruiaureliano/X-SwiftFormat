import Cocoa

class AboutViewController: NSViewController {

	@IBOutlet weak var appName: NSTextField!
	@IBOutlet weak var appVersion: NSTextField!

	@IBOutlet weak var andreTwitter: NSButton!
	@IBOutlet weak var andreDribble: NSButton!
	@IBOutlet weak var ruiTwitter: NSButton!
	@IBOutlet weak var ruiGithub: NSButton!

	private var effectiveAppearanceObservation: NSKeyValueObservation?

	override func viewDidLoad() {
		super.viewDidLoad()

		if let executable = Bundle.main.CFBundleExecutable {
			appName.stringValue = executable
		}

		if let version = Bundle.main.CFBundleShortVersionString, let build = Bundle.main.CFBundleVersion {
			appVersion.stringValue = "Version: \(version) (\(build))"
		}

		effectiveAppearanceObservation = self.view.observe(\.effectiveAppearance, options: [.old, .new]) { _, _ in
			self.andreTwitter.tintImage(with: .selectedContentBackgroundColor)
			self.andreDribble.tintImage(with: .selectedContentBackgroundColor)
			self.ruiTwitter.tintImage(with: .selectedContentBackgroundColor)
			self.ruiGithub.tintImage(with: .selectedContentBackgroundColor)
		}
	}
}
