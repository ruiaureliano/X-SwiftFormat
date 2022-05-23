import Cocoa

class CellComboView: NSView {

	static var identifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "CellComboView")

	@IBOutlet weak var labelCheck: NSButton!
	@IBOutlet weak var popupField: NSPopUpButton!
	@IBOutlet weak var popupFieldConstraint: NSLayoutConstraint!

	private var key: String = ""
	private var on: Bool = false
	private var labels: [String] = []
	private var value: String = ""
	private var sharedConfiguration: SharedConfiguration?

	func setKey(key: String, on: Bool, labels: [String], value: String, sharedConfiguration: SharedConfiguration) {

		self.key = key
		self.labels = labels
		self.value = value
		self.sharedConfiguration = sharedConfiguration
		self.labelCheck.title = SharedConfiguration.label(for: key)

		popupField.removeAllItems()
		popupField.addItems(withTitles: labels.map { $0.lowercased() })
		if let large = labels.sorted(by: { $0.count > $1.count }).first {
			let width = large.widthWithConstrainedHeight(height: 25, font: NSFont.systemFont(ofSize: 13, weight: .light))
			popupFieldConstraint.constant = 34 + width
		}

		let index = labels.firstIndex(of: value) ?? 0
		popupField.selectItem(at: index)

		if on {
			labelCheck.state = .on
			popupField.isEnabled = true

		} else {
			labelCheck.state = .off
			popupField.isEnabled = false
		}
	}

	@IBAction func labelCheckPress(_ check: NSButton) {
		popupField.isEnabled = (labelCheck.state == .on)
		let popupString = popupField.selectedItem?.title.lowercased() ?? "private"
		sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), value: popupString)
	}

	@IBAction func popupFieldPress(_ popup: NSPopUpButton) {
		let popupString = popupField.selectedItem?.title.lowercased() ?? "private"
		sharedConfiguration?.setConfig(key: self.key, on: (self.labelCheck.state == .on ? true : false), value: popupString)
	}
}
