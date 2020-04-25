//
//  AppIcon.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

private let kPercentagePadding: CGFloat = 0.06

class AppIcon: NSObject {

	class func with(image: NSImage, with color: NSColor) -> NSImage? {
		let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
		image.lockFocus()
		color.setFill()
		let percentage = kPercentagePadding * image.size.width
		NSBezierPath(ovalIn: CGRect(x: percentage, y: percentage, width: image.size.width - 2 * percentage, height: image.size.height - 2 * percentage)).fill()
		image.draw(in: rect)
		image.unlockFocus()
		return image
	}
}
