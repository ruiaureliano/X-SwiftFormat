//
//  XSFDocHandler.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 22/04/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class XSFDocHandler: NSObject {

	static func handle(filenames: [String]) {
		for filename in filenames {
			let components = filename.split(separator: "/")
			if let last = components.last {
				let split = last.split(separator: ".")
				if split.count == 2 {
					if let docType = XSFDocType(rawValue: String(split[1]).lowercased()) {
						switch docType {
						case .config:
							readConfigFile(with: URL(fileURLWithPath: filename))
						case .rules:
							readRulesFile(with: URL(fileURLWithPath: filename))
						}
					}
				}
			}
		}
	}

	static func readConfigFile(with url: URL) {
		if let data = try? Data(contentsOf: url) {
			if let json = data.json as? [String: Any] {
				var configuration: [String: Any] = [:]
				for entry in json {
					let key = entry.key
					let value = entry.value
					if key != "metadata" {
						configuration[key] = value
					}
				}
				_ = UserDefaults.saveConfiguration(configuration: configuration)
				NotificationCenter.default.post(name: kReadXSFFileNotification, object: nil)
			}
		}
	}

	static func readRulesFile(with url: URL) {
		if let data = try? Data(contentsOf: url) {
			if let json = data.json as? [String: Any] {
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
				NotificationCenter.default.post(name: kReadXSFFileNotification, object: nil)
			}
		}
	}
}
