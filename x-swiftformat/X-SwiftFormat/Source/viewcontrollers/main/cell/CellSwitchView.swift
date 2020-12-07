import Cocoa

class CellSwitchView: NSView {

	static var identifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "CellSwitchView")

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var switchButton: NSSwitch!

	private var key: String = ""
	private var on: Bool = false
	private var value: Bool = false
	private var isRule: Bool = false
	private var sharedConfiguration: SharedConfiguration?

	func setKey(key: String, on: Bool, value: Bool, isRule: Bool, sharedConfiguration: SharedConfiguration) {
		self.key = key
		self.on = on
		self.value = value
		self.isRule = isRule
		self.sharedConfiguration = sharedConfiguration

		self.labelCheck.title = SharedConfiguration.label(for: key)

		if on {
			labelCheck.state = .on
			switchButton.isEnabled = true
		} else {
			labelCheck.state = .off
			switchButton.isEnabled = false
		}
		switchButton.state = (value ? .on : .off)
	}

	@IBAction func labelCheckPress(_ check: NSButton) {
		switchButton.isEnabled = (labelCheck.state == .on)
		if isRule {
			sharedConfiguration?.setRule(key: self.key, on: (self.labelCheck.state == .on ? true : false), value: (self.switchButton.state == .on ? true : false))
		} else {
			sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), value: (self.switchButton.state == .on ? true : false))
		}
	}

	@IBAction func switchButtonChanged(_ button: NSSwitch) {
		if isRule {
			sharedConfiguration?.setRule(key: self.key, on: (self.labelCheck.state == .on ? true : false), value: (self.switchButton.state == .on ? true : false))
		} else {
			sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), value: (self.switchButton.state == .on ? true : false))
		}
	}
}
