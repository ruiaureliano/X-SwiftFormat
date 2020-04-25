//
//  TabRulesView+Delegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension TabRulesView: NSTableViewDataSource, NSTableViewDelegate {

	func numberOfRows(in tableView: NSTableView) -> Int {
		return Config.rules.count
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 28
	}

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TabRulesViewCellSwitch"), owner: self) as? TabRulesViewCellSwitch {
			let keys = Config.rules.keys.sorted()
			let key = keys[row]
			let object = Config.rules[key]
			cell.setKey(key: key, object: object, sharedRules: sharedRules)
			cell.delegate = self
			return cell
		}
		return nil
	}
}

extension TabRulesView: TabRulesViewCellDelegate {
	func switchChanged(key: String, labelValue: Bool, switchValue: Bool) {
		if labelValue {
			self.sharedRules[key] = switchValue
		} else {
			self.sharedRules.removeValue(forKey: key)
		}
		_ = UserDefaults.saveRules(rules: sharedRules)
		self.exportButton.isEnabled = (sharedRules.count > 0)
	}
}
