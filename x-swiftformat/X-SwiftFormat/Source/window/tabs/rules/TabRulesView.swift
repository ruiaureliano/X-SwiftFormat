//
//  TabRulesView.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class TabRulesView: NSTableView {

	var sharedRules: [String: Bool] = [:]

	override func awakeFromNib() {
		super.awakeFromNib()
		self.dataSource = self
		self.delegate = self
		self.sharedRules = UserDefaults.rules
	}

	func reloadDataSource() {
		self.sharedRules = UserDefaults.rules
		self.reloadData()
	}
}
