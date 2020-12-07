import Cocoa

let kReadXSFFileNotification = NSNotification.Name(rawValue: "kReadXSFFileNotification")

enum XSFDocType: String {
	case swiftformat = ""
}

class XSFDoc: NSDocument {

	override var windowNibName: String? {
		return nil
	}

	override func windowControllerDidLoadNib(_ aController: NSWindowController) {
		super.windowControllerDidLoadNib(aController)
	}

	override class var autosavesInPlace: Bool {
		return true
	}
}
