//
//  AnimatedButton.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

protocol AnimatedButtonDelegate: class {
	func animatedButtonMouseEntered(button: AnimatedButton)
	func animatedButtonMouseExited(button: AnimatedButton)
}

class AnimatedButton: NSButton {

	weak var delegate: AnimatedButtonDelegate?

	private var _alphaNormal: CGFloat = 0.75
	private var _alphaHover: CGFloat = 1
	private var _alphaHighlighted: CGFloat = 0.5

	override func awakeFromNib() {
		super.awakeFromNib()
		self.alphaValue = alphaNormal

		self.addTrackingArea(
			NSTrackingArea(
				rect: self.frame,
				options: [
					.mouseEnteredAndExited,
					.activeAlways,
					.inVisibleRect,
				], owner: self, userInfo: nil))
	}

	convenience init() {
		self.init(frame: NSRect(x: 0, y: 0, width: 0, height: 0))
	}

	override init(frame frameRect: NSRect) {
		super.init(frame: frameRect)
		self.alphaValue = alphaNormal
		self.isBordered = false
		self.setButtonType(NSButton.ButtonType.momentaryPushIn)
		self.bezelStyle = .roundRect
		self.addTrackingArea(
			NSTrackingArea(
				rect: self.frame,
				options: [
					.mouseEnteredAndExited,
					.activeAlways,
					.inVisibleRect,
				], owner: self, userInfo: nil))
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	@IBInspectable public var alphaNormal: CGFloat {
		get {
			return _alphaNormal
		}
		set {
			_alphaNormal = newValue
			self.alphaValue = newValue
		}
	}

	@IBInspectable public var alphaHover: CGFloat {
		get {
			return _alphaHover
		}
		set {
			_alphaHover = newValue
		}
	}

	@IBInspectable public var alphaHighlighted: CGFloat {
		get {
			return _alphaHighlighted
		}
		set {
			_alphaHighlighted = newValue
		}
	}

	var centerPosition: NSPoint? {
		if let window = self.window {
			return NSPoint(x: window.frame.midX, y: window.frame.midY)
		}
		return nil
	}

	override func mouseDown(with event: NSEvent) {
		if self.isEnabled {
			self.animator().alphaValue = alphaHighlighted
		}
		super.mouseDown(with: event)
		if self.isEnabled {
			self.animator().alphaValue = alphaHover
		}
	}

	override func mouseEntered(with event: NSEvent) {
		super.mouseEntered(with: event)
		if self.isEnabled {
			self.animator().alphaValue = alphaHover
			delegate?.animatedButtonMouseEntered(button: self)
		}
	}

	override func mouseExited(with event: NSEvent) {
		super.mouseExited(with: event)
		if self.isEnabled {
			self.animator().alphaValue = alphaNormal
			delegate?.animatedButtonMouseExited(button: self)
		}
	}
}
