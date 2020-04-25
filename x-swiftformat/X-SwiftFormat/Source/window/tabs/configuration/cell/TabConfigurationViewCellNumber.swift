//
//  TabConfigurationViewCellNumber.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class TabConfigurationViewCellNumber: NSView {

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var valueField: NSTextField!
	@IBOutlet weak var stepperField: NSStepper!

	private var key: String = ""
	weak var delegate: TabConfigurationViewCellDelegate?

	var min: Int = 1
	var max: Int = 10
	var increment: Int = 1

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	func setKey(key: String, object: [String: Any]?, sharedConfiguration: [String: Any]) {

		self.key = key
		self.labelCheck.title = key.reverseCamelCase

		if let object = object {
			let value: Int = object["value"] as? Int ?? 1
			self.min = object["min"] as? Int ?? 1
			self.max = object["max"] as? Int ?? 10
			self.increment = object["increment"] as? Int ?? 1

			valueField.stringValue = "\(value)"
			stepperField.integerValue = (value)
			stepperField.minValue = Double(min)
			stepperField.increment = Double(increment)
			stepperField.maxValue = Double(max)
		}

		if let sharedValue = sharedConfiguration[self.key] as? NSNumber {
			labelCheck.state = .on
			valueField.isEnabled = true
			stepperField.isEnabled = true
			valueField.stringValue = "\(sharedValue.intValue)"
			stepperField.integerValue = sharedValue.intValue
		} else {
			labelCheck.state = .off
			valueField.isEnabled = false
			stepperField.isEnabled = false
		}
	}

	@IBAction func labelCheckPress(_ check: NSButton) {
		valueField.isEnabled = (labelCheck.state == .on)
		stepperField.isEnabled = (labelCheck.state == .on)
		delegate?.numberChanged(key: key, labelValue: labelCheck.state == .on, stepperValue: stepperField.integerValue)
	}

	@IBAction func stepperFieldChanged(_ stepper: NSStepper) {
		valueField.stringValue = "\(stepperField.integerValue)"
		delegate?.numberChanged(key: key, labelValue: labelCheck.state == .on, stepperValue: stepperField.integerValue)
	}
}

extension TabConfigurationViewCellNumber: NSTextFieldDelegate {

	func controlTextDidChange(_ obj: Notification) {
		if let textfield = obj.object as? NSTextField {
			if textfield == valueField {
				if let value = Int(textfield.stringValue) {
					if value < min {
						valueField.stringValue = "\(min)"
						stepperField.integerValue = min
					} else if value > max {
						valueField.stringValue = "\(max)"
						stepperField.integerValue = max
					} else {
						stepperField.integerValue = value
					}
				} else {
					valueField.stringValue = "\(1)"
					stepperField.integerValue = 1
				}
				delegate?.numberChanged(key: key, labelValue: labelCheck.state == .on, stepperValue: stepperField.integerValue)
			}
		}
	}
}
