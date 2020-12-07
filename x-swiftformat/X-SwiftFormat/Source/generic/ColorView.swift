import Cocoa

@IBDesignable class ColorView: NSView {

	@IBInspectable public var color: NSColor = .white {
		didSet {
			self.needsDisplay = true
		}
	}

	@IBInspectable public var radius: CGFloat = 0.0 {
		didSet {
			self.needsDisplay = true
		}
	}

	@IBInspectable public var colorAlpha: CGFloat = 1.0 {
		didSet {
			self.needsDisplay = true
		}
	}

	override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
	}

	override var allowsVibrancy: Bool {
		return false
	}

	override func draw(_ dirtyRect: NSRect) {
		super.draw(dirtyRect)
		self.color.withAlphaComponent(colorAlpha).setFill()
		let bezier = NSBezierPath(roundedRect: dirtyRect, xRadius: self.radius, yRadius: self.radius)
		bezier.fill()
	}
}
