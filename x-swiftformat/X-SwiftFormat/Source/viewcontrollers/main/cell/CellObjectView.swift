import Cocoa

class CellObjectView: NSView, NSTextFieldDelegate {

	static var identifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "CellObjectView")

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var popupField: NSPopUpButton!
	@IBOutlet weak var valueField: NSTextField!
	@IBOutlet weak var stepperField: NSStepper!

	private var key: String = ""
	private var on: Bool = false
	private var label: String = ""
	private var labels: [String] = []
	private var value: Int = 1
	private var min: Int = 1
	private var max: Int = 10
	private var increment: Int = 1
	private var sharedConfiguration: SharedConfiguration?

	override func awakeFromNib() {
		super.awakeFromNib()
		valueField.delegate = self
	}

	func setKey(key: String, on: Bool, label: String, labels: [String], value: Int, min: Int = 1, max: Int = 10, increment: Int = 1, sharedConfiguration: SharedConfiguration) {

		self.key = key
		self.label = label
		self.labels = labels
		self.value = value
		self.min = min
		self.max = max
		self.increment = increment
		self.sharedConfiguration = sharedConfiguration

		self.labelCheck.title = SharedConfiguration.label(for: key)

		popupField.removeAllItems()
		popupField.addItems(withTitles: labels.map { $0.capitalized })
		let index = labels.firstIndex(of: label) ?? 0
		popupField.selectItem(at: index)

		if on {
			labelCheck.state = .on
			popupField.isEnabled = true
			valueField.isEnabled = true
			stepperField.isEnabled = true
		} else {
			labelCheck.state = .off
			popupField.isEnabled = false
			valueField.isEnabled = false
			stepperField.isEnabled = false
		}

		valueField.stringValue = "\(value)"
		stepperField.integerValue = value
		stepperField.minValue = Double(min)
		stepperField.increment = Double(increment)
		stepperField.maxValue = Double(max)
	}

	@IBAction func labelCheckPress(_ check: NSButton) {
		popupField.isEnabled = (labelCheck.state == .on)
		valueField.isEnabled = (labelCheck.state == .on)
		stepperField.isEnabled = (labelCheck.state == .on)
		let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
		sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), label: popupString, value: stepperField.integerValue)
	}

	@IBAction func popupFieldPress(_ popup: NSPopUpButton) {
		let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
		sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), label: popupString, value: stepperField.integerValue)
	}

	@IBAction func stepperFieldChanged(_ stepper: NSStepper) {
		valueField.stringValue = "\(stepperField.integerValue)"
		let popupString = popupField.selectedItem?.title.lowercased() ?? "spaces"
		sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), label: popupString, value: stepperField.integerValue)
	}

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
				sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), label: popupString, value: stepperField.integerValue)
			}
		}
	}
}
