//
//  TabConfigurationViewCellSwitch.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class TabConfigurationViewCellSwitch: NSView {

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var switchButton: NSSwitch!

	private var key: String = ""
	weak var delegate: TabConfigurationViewCellDelegate?

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	func setKey(key: String, object: [String: Any]?, sharedConfiguration: [String: Any]) {

		self.key = key
		self.labelCheck.title = key.reverseCamelCase

		if let object = object {
			let value: Bool = object["value"] as? Bool ?? false
			switchButton.state = (value ? .on : .off)
		}

		if let sharedValue = sharedConfiguration[self.key] as? Bool {
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
