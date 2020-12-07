import Cocoa

class MainWindowController: NSWindowController {

	override func windowDidLoad() {
		super.windowDidLoad()
		self.window?.isMovableByWindowBackground = true
	}
}
