import Cocoa

private let kRulesEntryName = "rules"

extension MainViewController: NSTableViewDataSource, NSTableViewDelegate {

	func numberOfRows(in tableView: NSTableView) -> Int {
		if tableView == configurationTableView {
			return sharedConfiguration.configuration.count
		} else if tableView == rulesTableView {
			return sharedConfiguration.rules.count
		}
		return 0
	}

	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 28
	}

	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		if tableView == configurationTableView {
			let allkeys = SharedConfiguration.configKeys
			let key = allkeys[row]
			if let config = sharedConfiguration.configuration[key] as? [String: Any], let type = config["type"] as? String {
				if type == "boolean" {
					if let cell = tableView.makeView(withIdentifier: CellSwitchView.identifier, owner: self) as? CellSwitchView {
						if let on = config["on"] as? Bool, let value = config["value"] as? Bool {
							cell.setKey(key: key, on: on, value: value, isRule: false, sharedConfiguration: sharedConfiguration)
						}
						return cell
					}
				} else if type == "number" {
					if let cell = tableView.makeView(withIdentifier: CellNumberView.identifier, owner: self) as? CellNumberView {
						if let on = config["on"] as? Bool, let value = config["value"] as? Int, let min = config["min"] as? Int, let max = config["max"] as? Int, let increment = config["increment"] as? Int {
							cell.setKey(key: key, on: on, value: value, min: min, max: max, increment: increment, sharedConfiguration: sharedConfiguration)
						}
						return cell
					}
				} else if type == "combo_num" {
					if let cell = tableView.makeView(withIdentifier: CellComboNumView.identifier, owner: self) as? CellComboNumView {
						if let on = config["on"] as? Bool, let label = config["label"] as? String, let labels = config["labels"] as? [String], let value = config["value"] as? Int {
							if let min = config["min"] as? Int, let max = config["max"] as? Int, let increment = config["increment"] as? Int {
								cell.setKey(key: key, on: on, label: label, labels: labels, value: value, min: min, max: max, increment: increment, sharedConfiguration: sharedConfiguration)
							}
						}
						return cell
					}
				} else if type == "combo" {
					if let cell = tableView.makeView(withIdentifier: CellComboView.identifier, owner: self) as? CellComboView {
						if let on = config["on"] as? Bool, let value = config["value"] as? String, let labels = config["labels"] as? [String] {
							cell.setKey(key: key, on: on, labels: labels, value: value, sharedConfiguration: sharedConfiguration)
						}
						return cell
					}
				}
			}
		} else if tableView == rulesTableView {
			let allkeys = SharedConfiguration.ruleKeys
			let key = allkeys[row]
			if let rule = sharedConfiguration.rules[key] as? [String: Any], let type = rule["type"] as? String {
				if type == "boolean" {
					if let cell = tableView.makeView(withIdentifier: CellSwitchView.identifier, owner: self) as? CellSwitchView {
						if let on = rule["on"] as? Bool, let value = rule["value"] as? Bool {
							cell.setKey(key: key, on: on, value: value, isRule: true, sharedConfiguration: sharedConfiguration)
							return cell
						}
					}
				}
			}
		}
		return nil
	}
}
