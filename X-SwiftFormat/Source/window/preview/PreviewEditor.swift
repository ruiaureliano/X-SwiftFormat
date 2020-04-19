//
//  PreviewEditor.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

private let kEditorFont: NSFont? = NSFont(name: "Menlo", size: 12)

class PreviewEditor: NSTextView {

	var previewEditorSyntax = PreviewEditorSyntax()

	override func awakeFromNib() {
		super.awakeFromNib()
		self.font = kEditorFont
		self.textColor = NSColor(named: "preview-text-color")
		self.textContainer?.replaceLayoutManager(PreviewEditorLayoutManager())
		self.textStorage?.delegate = self
		self.delegate = self
	}

	override var readablePasteboardTypes: [NSPasteboard.PasteboardType] {
		return [.string]
	}

	func syntaxHighlighted() {

		var text = self.string
		text = text.replacingOccurrences(of: "“", with: "\"")
		text = text.replacingOccurrences(of: "”", with: "\"")
		self.string = text

		previewEditorSyntax.hightlightSource(text: self.string, in: self)

		self.needsDisplay = true
	}
}
