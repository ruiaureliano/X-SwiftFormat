//
//  AppDelegate+Delegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 19/04/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension AppDelegate: NSTabViewDelegate {

	func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
		var tabOption: TabOption = .configuration
		if let selectedTabViewItem = tabViewItem {
			if let option = TabOption(rawValue: selectedTabViewItem.label) {
				tabOption = option
			}
		}
		switch tabOption {
		case .configuration:
			tabViewConfiguration.reloadDataSource()
		case .rules:
			tabViewRules.reloadDataSource()
		}
	}
}
