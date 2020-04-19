//
//  AppDelegate+Actions.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension AppDelegate {

	@IBAction func appVersionButtonPopover(_ button: NSButton) {
		let width = 250
		let controller = NSViewController()
		let popover = NSPopover()
		self.popover = popover
		controller.view = NSView(frame: NSRect(x: 0, y: 0, width: width, height: 80))
		popover.contentViewController = controller
		popover.contentSize = controller.view.frame.size
		popover.behavior = .semitransient
		popover.animates = true

		let textField = NSTextField(string: "🚀 New Version: \(appVersionName ?? "Version 1")")
		textField.frame = NSRect(x: 10, y: 42, width: width - 20, height: 20)
		textField.isBezeled = false
		textField.drawsBackground = true
		textField.backgroundColor = .clear
		textField.isEditable = false
		textField.isSelectable = false
		textField.alignment = .center
		controller.view.addSubview(textField)

		let downloadVersion = NSButton(frame: NSRect(x: (width - 100) / 2, y: 5, width: 100, height: 32))
		downloadVersion.isBordered = false
		downloadVersion.title = "Download"
		downloadVersion.image = NSImage(named: "default-download-bt")
		downloadVersion.target = self
		downloadVersion.action = #selector(self.appVersionButtonPress(_:))
		downloadVersion.bezelStyle = .rounded
		controller.view.addSubview(downloadVersion)

		popover.show(relativeTo: .zero, of: button, preferredEdge: .maxY)
	}

	@objc func appVersionButtonPress(_ button: NSButton) {
		popover?.close()
		if let appVersionButtonURL = appVersionButtonURL {
			if let url = URL(string: appVersionButtonURL) {
				NSWorkspace.shared.open(url)
			}
		}
	}

	@IBAction func andreTwitterPress(_ button: AnimatedButton) {
		if let url = URL(string: "https://twitter.com/andre_goncalves") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func andreDribblePress(_ button: AnimatedButton) {
		if let url = URL(string: "https://dribbble.com/andre_goncalves") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func ruiTwitterPress(_ button: AnimatedButton) {
		if let url = URL(string: "https://twitter.com/ruiaureliano") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func ruiGithubPress(_ button: AnimatedButton) {
		if let url = URL(string: "https://github.com/ruiaureliano") {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func versionButtonPress(_ button: NSButton) {
		if let url = URL(string: kSwiftFormatURL) {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func resetButtonPress(_ button: NSButton) {
		let alert = NSAlert()
		alert.messageText = "Reset Configuration & Rules"
		alert.informativeText = "Are you sure you want to proceed?"
		alert.alertStyle = .critical
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")
		alert.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1000 {
				_ = UserDefaults.deleteConfiguration()
				_ = UserDefaults.deleteRules()
				self.tabViewConfiguration.reloadDataSource()
				self.tabViewRules.reloadDataSource()
			}
		}
	}

	@IBAction func previewButtonPress(_ button: NSButton) {
		previewWindow.openWithConfiguration(configuration: tabViewConfiguration.sharedConfiguration, rules: tabViewRules.sharedRules)
		previewWindow.makeKeyAndOrderFront(self)
	}

	@IBAction func exportButtonPress(_ button: NSButton) {
		let savePanel = NSSavePanel()
		savePanel.canCreateDirectories = true
		savePanel.showsTagField = false
		savePanel.nameFieldStringValue = ".swift-format"
		savePanel.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1 {
				if let url = savePanel.url {
					if let json = self.tabViewConfiguration.sharedConfiguration.jsonPretty {
						try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
					}
				}
			}
		}
	}
}
