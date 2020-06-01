//
//  AppDelegate+Actions.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension AppDelegate {

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
}
