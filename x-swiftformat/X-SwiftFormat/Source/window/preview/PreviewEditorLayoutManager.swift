//
//  PreviewEditorLayoutManager.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class PreviewEditorLayoutManager: NSLayoutManager {

	var drawInvisibles: Bool = false

	override func drawGlyphs(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
		guard let context = NSGraphicsContext.current else {
			return
		}

		if drawInvisibles {
			if let textStorage = textStorage {
				context.saveGraphicsState()
				context.cgContext.translateBy(x: origin.x, y: origin.y)

				let completeString = textStorage.string
				let lengthToRedraw = NSMaxRange(glyphsToShow)
				let textFontAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: NSColor(named: "preview-invisibles-color") as Any]

				for index in glyphsToShow.location..<lengthToRedraw {
					let characterToCheck = completeString[completeString.index(completeString.startIndex, offsetBy: index)]
					if characterToCheck == "\t" {
						var pointToDrawAt = self.location(forGlyphAt: index)
						let glyphFragment = self.lineFragmentRect(forGlyphAt: index, effectiveRange: nil)
						pointToDrawAt.x += glyphFragment.origin.x
						pointToDrawAt.y = glyphFragment.origin.y
						"»".draw(at: pointToDrawAt, withAttributes: textFontAttributes)
					} else if characterToCheck == "\n" {
						var pointToDrawAt = self.location(forGlyphAt: index)
						let glyphFragment = self.lineFragmentRect(forGlyphAt: index, effectiveRange: nil)
						pointToDrawAt.x += glyphFragment.origin.x
						pointToDrawAt.y = glyphFragment.origin.y
						"¬".draw(at: pointToDrawAt, withAttributes: textFontAttributes)
					} else if characterToCheck == " " {
						var pointToDrawAt = self.location(forGlyphAt: index)
						let glyphFragment = self.lineFragmentRect(forGlyphAt: index, effectiveRange: nil)
						pointToDrawAt.x += glyphFragment.origin.x
						pointToDrawAt.y = glyphFragment.origin.y
						"∙".draw(at: pointToDrawAt, withAttributes: textFontAttributes)
					}
				}
				context.restoreGraphicsState()
			}
		}
		super.drawGlyphs(forGlyphRange: glyphsToShow, at: origin)
	}
}
