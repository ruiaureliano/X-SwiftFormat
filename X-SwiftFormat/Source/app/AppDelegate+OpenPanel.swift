//
//  AppDelegate+OpenPanel.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 19/04/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension AppDelegate {

	@IBAction func openDocumentFile(_ button: NSMenuItem) {
		let dialog = NSOpenPanel()
		dialog.showsHiddenFiles = true
		dialog.canChooseDirectories = false
		dialog.allowedFileTypes = ["json"]

		if dialog.runModal() == .OK {
			if let url = dialog.url {
				if let data = try? Data(contentsOf: url) {
					if let json = data.json as? [String: Any] {
						if let metadata = json["metadata"] as? [String: String] {
							if metadata["type"] == "configuration" {
								var configuration: [String: Any] = [:]
								for entry in json {
									let key = entry.key
									let value = entry.value
									if key != "metadata" {
										configuration[key] = value
									}
								}
								_ = UserDefaults.saveConfiguration(configuration: configuration)
								tabViewConfiguration.reloadDataSource()
							} else if metadata["type"] == "rules" {
								var rules: [String: Bool] = [:]
								for entry in json {
									let key = entry.key
									if let value = entry.value as? Bool {
										if key != "metadata" {
											rules[key] = value
										}
									}
								}
								_ = UserDefaults.saveRules(rules: rules)
								tabViewRules.reloadDataSource()
							}
						}
					}
				}
			}
		}
	}
}
