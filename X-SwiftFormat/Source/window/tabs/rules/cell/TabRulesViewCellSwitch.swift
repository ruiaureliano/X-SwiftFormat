//
//  TabRulesViewCellSwitch.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class TabRulesViewCellSwitch: NSView {

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var switchButton: NSSwitch!

	private var key: String = ""
	weak var delegate: TabRulesViewCellDelegate?

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	func setKey(key: String, object: Bool?, sharedRules: [String: Bool]) {

		self.key = key
		self.labelCheck.title = key.reverseCamelCase

		if let object = object {
			switchButton.state = (object ? .on : .off)
		}

		if let sharedValue = sharedRules[self.key] {
			labelCheck.state = .on
			switchButton.isEnabled = true
			switchButton.state = (sharedValue ? .on : .off)
		} else {
			labelCheck.state = .off
			switchButton.isEnabled = false
		}
	}

	@IBAction func labelCheckPress(_ check: NSButton) {
		switchButton.isEnabled = (labelCheck.state == .on)
		delegate?.switchChanged(key: key, labelValue: labelCheck.state == .on, switchValue: switchButton.state == .on)
	}

	@IBAction func switchButtonChanged(_ button: NSSwitch) {
		delegate?.switchChanged(key: key, labelValue: labelCheck.state == .on, switchValue: switchButton.state == .on)
	}
}
