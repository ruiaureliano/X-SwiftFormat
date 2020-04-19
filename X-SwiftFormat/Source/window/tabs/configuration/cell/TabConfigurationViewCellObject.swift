//
//  TabConfigurationViewCellObject.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class TabConfigurationViewCellObject: NSView {

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var popupField: NSPopUpButton!
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

			popupField.removeAllItems()
			if let options = object["options"] as? [String] {
				popupField.addItems(withTitles: options.map { $0.capitalized })
			}
		}

		if let sharedValue = sharedConfiguration[self.key] as? [String: Any] {
			labelCheck.state = .on
			popupField.isEnabled = true
			valueField.isEnabled = true
			stepperField.isEnabled = true
			if let spaces = sharedValue["spaces"] as? NSNumber {
				let stepper = spaces.intValue
				valueField.stringValue = "\(stepper)"
				stepperField.integerValue = Int(stepper)
				popupField.selectItem(at: 0)
			} else if let tabs = sharedValue["tabs"] as? NSNumber {
				let stepper = tabs.intValue
				valueField.stringValue = "\(stepper)"
				stepperField.integerValue = Int(stepper)
				popupField.selectItem(at: 1)
			}
		} else {
			labelCheck.state = .off
			popupField.isEnabled = false
			valueField.isEnabled = false
			stepperField.isEnabled = false
		}
	}

	@IBAction func labelCheckPress(_ check: NSButton) {
		popupField.isEnabled = (labelCheck.state == .on)
		valueField.isEnabled = (labelCheck.state == .on)
		stepperField.isEnabled = (labelCheck.state == .on)
		let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
		delegate?.objectChanged(key: key, labelValue: labelCheck.state == .on, popup: popupString, stepperValue: stepperField.integerValue)
	}

	@IBAction func popupFieldPress(_ popup: NSPopUpButton) {
		let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
		delegate?.objectChanged(key: key, labelValue: labelCheck.state == .on, popup: popupString, stepperValue: stepperField.integerValue)
	}

	@IBAction func stepperFieldChanged(_ stepper: NSStepper) {
		valueField.stringValue = "\(stepperField.integerValue)"
		let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
		delegate?.objectChanged(key: key, labelValue: labelCheck.state == .on, popup: popupString, stepperValue: stepperField.integerValue)
	}
}

extension TabConfigurationViewCellObject: NSTextFieldDelegate {

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
				let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
				delegate?.objectChanged(key: key, labelValue: labelCheck.state == .on, popup: popupString, stepperValue: stepperField.integerValue)
			}
		}
	}
}
