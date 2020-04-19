//
//  TabConfigurationView.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class TabConfigurationView: NSTableView {

	@IBOutlet weak var exportButton: NSButton!
	var sharedConfiguration: [String: Any] = [:]

	override func awakeFromNib() {
		super.awakeFromNib()
		self.dataSource = self
		self.delegate = self
		self.sharedConfiguration = UserDefaults.configuration
		self.exportButton.isEnabled = (sharedConfiguration.count > 0)
	}

	func reloadDataSource() {
		self.sharedConfiguration = UserDefaults.configuration
		self.exportButton.isEnabled = (sharedConfiguration.count > 0)
		self.reloadData()
	}
}
