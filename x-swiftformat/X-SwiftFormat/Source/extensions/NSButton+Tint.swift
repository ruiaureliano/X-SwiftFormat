import Cocoa

extension NSButton {

	func tintImage(with color: NSColor) {
		guard let image = self.image else { return }
		self.image = image.tint(color: color)
	}
}
