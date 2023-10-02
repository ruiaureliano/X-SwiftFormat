import Cocoa

let kReadXSFFileNotification = NSNotification.Name(rawValue: "kReadXSFFileNotification")

class XSFDoc: NSDocument {

	override var windowNibName: String? {
		return nil
	}

	override class var autosavesInPlace: Bool {
		return true
	}
}
