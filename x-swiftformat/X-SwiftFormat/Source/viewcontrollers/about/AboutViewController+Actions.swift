import Cocoa

extension AboutViewController {

	@IBAction func andreTwitterPress(_ button: NSButton) {
		if let url = URL(string: "https://twitter.com/andre_goncalves") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func andreDribblePress(_ button: NSButton) {
		if let url = URL(string: "https://dribbble.com/andre_goncalves") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func ruiTwitterPress(_ button: NSButton) {
		if let url = URL(string: "https://twitter.com/ruiaureliano") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func ruiGithubPress(_ button: NSButton) {
		if let url = URL(string: "https://github.com/ruiaureliano") {
			NSWorkspace.shared.open(url)
		}
	}
}
