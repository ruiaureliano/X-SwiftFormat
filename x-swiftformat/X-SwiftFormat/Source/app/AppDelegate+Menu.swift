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
		dialog.allowedFileTypes = [XSFDocType.config.rawValue, XSFDocType.rules.rawValue]

		if dialog.runModal() == .OK {
			for url in dialog.urls {
				if let docType = XSFDocType(rawValue: url.pathExtension.lowercased()) {
					switch docType {
					case .config:
						XSFDocHandler.readConfigFile(with: url)
					case .rules:
						XSFDocHandler.readRulesFile(with: url)
					}
				}
			}
		}
	}

	@IBAction func exportMenuItem(_ button: NSMenuItem) {
		exportFiles()
	}

	@IBAction func previewMenuItem(_ button: NSMenuItem) {
		previewWindow.openWithConfiguration(configuration: tabViewConfiguration.sharedConfiguration, rules: tabViewRules.sharedRules)
		previewWindow.makeKeyAndOrderFront(self)
	}
}
