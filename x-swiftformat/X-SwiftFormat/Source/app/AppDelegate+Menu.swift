import Cocoa

extension AppDelegate {

	@IBAction func openFile(_ button: NSMenuItem) {
		if let window = NSApp.windows.first {
			let openPanel = NSOpenPanel()
			openPanel.showsHiddenFiles = true
			openPanel.canChooseDirectories = false
			openPanel.allowsMultipleSelection = false
			openPanel.allowedFileTypes = [XSFDocType.swiftformat.rawValue]

			openPanel.beginSheetModal(for: window) { response in
				if response.rawValue == 1 {
					if let url = openPanel.urls.first {
						if let docType = XSFDocType(rawValue: url.pathExtension.lowercased()) {
							switch docType {
							case .swiftformat:
								XSFDocHandler.readSwiftFormatFile(with: url)
							}
						}
					}
				}
			}
		}
	}

	@IBAction func saveFile(_ button: NSMenuItem) {
		if let window = NSApp.windows.first {
			let savePanel = NSSavePanel()
			savePanel.canCreateDirectories = true
			savePanel.showsTagField = false
			savePanel.nameFieldStringValue = ".swift-format"
			savePanel.beginSheetModal(for: window) { response in
				if response.rawValue == 1 {
					if let url = savePanel.url {
						let payload = SharedConfiguration.loadConfiguration().payload
						if let json = payload.jsonPretty {
							try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
						}
					}
				}
			}
		}
	}
}
