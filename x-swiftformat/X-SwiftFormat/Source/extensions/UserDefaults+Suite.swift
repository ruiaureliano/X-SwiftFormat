//
//  UserDefaults+Suite.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

private let kUserDefaultsSuiteName = "group.com.ruiaureliano.xswiftformat"
private let kUserDefaultsConfiguration = "kUserDefaultsConfiguration"
private let kUserDefaultsRules = "kUserDefaultsRules"

let kUserDefaultsChangedNotification = NSNotification.Name(rawValue: "kUserDefaultsChangedNotification")

extension UserDefaults {

	class func saveConfiguration(configuration: [String: Any]) -> Bool {
		if let defaults = UserDefaults(suiteName: kUserDefaultsSuiteName) {
			if let json = configuration.json {
				NotificationCenter.default.post(name: kUserDefaultsChangedNotification, object: nil)
				defaults.set(json, forKey: kUserDefaultsConfiguration)
				defaults.synchronize()
				return true
			}
		}
		return false
	}

	static var configuration: [String: Any] {
		if let defaults = UserDefaults(suiteName: kUserDefaultsSuiteName) {
			if let json = defaults.string(forKey: kUserDefaultsConfiguration) {
				if let data = json.data(using: .utf8) {
					if let configuration = data.json as? [String: Any] {
						return configuration
					}
				}
			}
		}
		return [:]
	}

	class func deleteConfiguration() -> Bool {
		if let defaults = UserDefaults(suiteName: kUserDefaultsSuiteName) {
			NotificationCenter.default.post(name: kUserDefaultsChangedNotification, object: nil)
			defaults.removeObject(forKey: kUserDefaultsConfiguration)
			defaults.synchronize()
			return true
		}
		return false
	}

	class func saveRules(rules: [String: Bool]) -> Bool {
		if let defaults = UserDefaults(suiteName: kUserDefaultsSuiteName) {
			if let json = rules.json {
				NotificationCenter.default.post(name: kUserDefaultsChangedNotification, object: nil)
				defaults.set(json, forKey: kUserDefaultsRules)
				defaults.synchronize()
				return true
			}
		}
		return false
	}

	static var rules: [String: Bool] {
		if let defaults = UserDefaults(suiteName: kUserDefaultsSuiteName) {
			if let json = defaults.string(forKey: kUserDefaultsRules) {
				if let data = json.data(using: .utf8) {
					if let rules = data.json as? [String: Bool] {
						return rules
					}
				}
			}
		}
		return [:]
	}

	class func deleteRules() -> Bool {
		if let defaults = UserDefaults(suiteName: kUserDefaultsSuiteName) {
			NotificationCenter.default.post(name: kUserDefaultsChangedNotification, object: nil)
			defaults.removeObject(forKey: kUserDefaultsRules)
			defaults.synchronize()
			return true
		}
		return false
	}
}
