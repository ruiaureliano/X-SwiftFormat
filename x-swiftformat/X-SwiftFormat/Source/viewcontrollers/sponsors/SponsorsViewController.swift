import Cocoa

class SponsorsViewController: NSViewController {

	@IBOutlet weak var coffeeBt: NSButton!
	@IBOutlet weak var beerBt: NSButton!
	@IBOutlet weak var lunchBt: NSButton!
	@IBOutlet weak var cancelBt: NSButton!

	static func showSponsorWindow() -> Bool {
		guard let version = Bundle.main.CFBundleShortVersionString, UserDefaults.standard.bool(forKey: version) == false else {
			return false
		}
		return true
	}

	@IBAction func coffeeBtPress(_ button: NSButton) {
		if let url = URL(string: "https://github.com/sponsors/ruiaureliano/sponsorships?sponsor=ruiaureliano&tier_id=26073&preview=false") {
			NSWorkspace.shared.open(url)
		}
		closeWindow()
	}

	@IBAction func beerBtPress(_ button: NSButton) {
		if let url = URL(string: "https://github.com/sponsors/ruiaureliano/sponsorships?sponsor=ruiaureliano&tier_id=26074&preview=false") {
			NSWorkspace.shared.open(url)
		}
		closeWindow()
	}

	@IBAction func lunchBtPress(_ button: NSButton) {
		if let url = URL(string: "https://github.com/sponsors/ruiaureliano/sponsorships?sponsor=ruiaureliano&tier_id=26075&preview=false") {
			NSWorkspace.shared.open(url)
		}
		closeWindow()
	}

	@IBAction func cancelBtPress(_ button: NSButton) {
		closeWindow()
	}

	func closeWindow() {
		guard
			let window = self.view.window,
			let version = Bundle.main.CFBundleShortVersionString
		else {
			return
		}
		UserDefaults.standard.setValue(true, forKey: version)
		window.close()
	}
}
