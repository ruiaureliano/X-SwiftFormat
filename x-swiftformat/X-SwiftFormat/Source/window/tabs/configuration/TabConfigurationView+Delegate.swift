//
//  TabConfigurationView+Delegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension TabConfigurationView: NSTableViewDataSource, NSTableViewDelegate {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return Config.configuration.count
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 28
	}

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let configuration = Config.configuration[row]
		if let type = configuration["type"] as? String, let key = configuration["key"] as? String {
			if type == "number" {
				if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabConfigurationViewCellNumber"), owner: self) as? TabConfigurationViewCellNumber {
					cell.setKey(key: key, object: configuration, sharedConfiguration: sharedConfiguration)
					cell.delegate = self
					return cell
				}
			} else if type == "boolean" {
				if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabConfigurationViewCellSwitch"), owner: self) as? TabConfigurationViewCellSwitch {
					cell.setKey(key: key, object: configuration, sharedConfiguration: sharedConfiguration)
					cell.delegate = self
					return cell
				}
			} else {
				if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabConfigurationViewCellObject"), owner: self) as? TabConfigurationViewCellObject {
					cell.setKey(key: key, object: configuration, sharedConfiguration: sharedConfiguration)
					cell.delegate = self
					return cell
				}
			}
		}
		return nil
	}
}

extension TabConfigurationView: TabConfigurationViewCellDelegate {

	func switchChanged(key: String, labelValue: Bool, switchValue: Bool) {
		if labelValue {
			self.sharedConfiguration[key] = switchValue
		} else {
			self.sharedConfiguration.removeValue(forKey: key)
		}
		_ = UserDefaults.saveConfiguration(configuration: sharedConfiguration)
	}

	func numberChanged(key: String, labelValue: Bool, stepperValue: Int) {
		if labelValue {
			self.sharedConfiguration[key] = stepperValue
		} else {
			self.sharedConfiguration.removeValue(forKey: key)
		}
		_ = UserDefaults.saveConfiguration(configuration: sharedConfiguration)
	}

	func objectChanged(key: String, labelValue: Bool, popup: String, stepperValue: Int) {
		if labelValue {
			self.sharedConfiguration[key] = [popup: stepperValue]
		} else {
			self.sharedConfiguration.removeValue(forKey: key)
		}
		_ = UserDefaults.saveConfiguration(configuration: sharedConfiguration)
	}
}
