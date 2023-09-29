import Cocoa
import SwiftFormat
import SwiftFormatConfiguration

extension PreviewViewController {

	@IBAction func showInvisiblesBtPress(_ _switch: NSSwitch) {
		if let layoutManager = previewEditor.layoutManager as? PreviewEditorLayoutManager {
			let drawInvisibles = (_switch.state == .on)
			layoutManager.drawInvisibles = drawInvisibles
			previewEditor.needsDisplay = true
		}
	}

	@IBAction func previewFormatBtPress(_ button: NSButton) {
		let sharedConfiguration = SharedConfiguration.loadConfiguration()
		let configuration = Configuration.buildConfiguration(with: sharedConfiguration.payload)
		let swiftFormatter = SwiftFormatter(configuration: configuration)
		var swiftFormatOutputStream = SwiftFormatOutputStream()

		do {
			try swiftFormatter.format(source: self.previewEditor.string, assumingFileURL: nil, to: &swiftFormatOutputStream)
			if let output = swiftFormatOutputStream.output {
				self.previewEditor.string = output
			}
		} catch {
			var informativeText = error.localizedDescription
			if let swiftFormatError = error as? SwiftFormatError {
				switch swiftFormatError {
				case .fileNotReadable:
					informativeText = "The requested file was not readable or it did not exist."
				case .isDirectory:
					informativeText = "The requested file was a directory."
				case .fileContainsInvalidSyntax:
					informativeText = "The file contains invalid or unrecognized Swift syntax and cannot be handled safely."
				}
			}
			let alert = NSAlert()
			alert.messageText = "Error"
			alert.informativeText = informativeText
			alert.alertStyle = .critical
			alert.addButton(withTitle: "OK")
			guard let window = NSApp.mainWindow else {
				_ = alert.runModal()
				return
			}
			alert.beginSheetModal(for: window) { (_) in
			}
		}

	}
}
