//
//  AppDelegate+Menu.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 19/04/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension AppDelegate {

	@IBAction func openAppMenuItem(_ button: NSMenuItem) {
		if !window.isMainWindow || !window.isKeyWindow {
			window.makeKeyAndOrderFront(self)
		}
	}

	@IBAction func importMenuItem(_ button: NSMenuItem) {
		let dialog = NSOpenPanel()
		dialog.showsHiddenFiles = true
		dialog.canChooseDirectories = false
		dialog.allowsMultipleSelection = true
		dialog.allowedFileTypes = [XSFDocType.swiftformat.rawValue]
		if dialog.runModal() == .OK {
			for url in dialog.urls {
				if let docType = XSFDocType(rawValue: url.pathExtension.lowercased()) {
					switch docType {
					case .swiftformat:
						XSFDocHandler.readSwiftFormatFile(with: url)
					}
				}
			}
		}
	}

	@IBAction func exportMenuItem(_ button: NSMenuItem) {
		let savePanel = NSSavePanel()
		savePanel.canCreateDirectories = true
		savePanel.showsTagField = false
		savePanel.nameFieldStringValue = ".swift-format"
		savePanel.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1 {
				if let url = savePanel.url {
					var swiftformat: [String: Any] = UserDefaults.configuration
					if UserDefaults.rules.count > 0 {
						swiftformat["rules"] = UserDefaults.rules
					}
					if let json = swiftformat.jsonPretty {
						try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
					}
				}
			}
		}
	}

	@IBAction func previewMenuItem(_ button: NSMenuItem) {
		previewWindow.openWithConfiguration(configuration: tabViewConfiguration.sharedConfiguration, rules: tabViewRules.sharedRules)
		previewWindow.makeKeyAndOrderFront(self)
	}
}
