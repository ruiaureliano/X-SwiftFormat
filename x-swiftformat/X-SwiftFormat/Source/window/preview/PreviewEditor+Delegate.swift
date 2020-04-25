//
//  PreviewEditor+Delegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension PreviewEditor: NSTextStorageDelegate {

	override func textStorageDidProcessEditing(_ notification: Notification) {
		syntaxHighlighted()
	}
}

extension PreviewEditor: NSTextViewDelegate {
	func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
		if commandSelector == NSSelectorFromString("noop:") {
			return true
		}
		return false
	}
}
