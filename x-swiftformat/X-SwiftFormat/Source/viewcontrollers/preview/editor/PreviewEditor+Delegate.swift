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
