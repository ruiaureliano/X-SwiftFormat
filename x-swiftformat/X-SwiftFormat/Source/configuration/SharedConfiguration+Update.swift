import Cocoa

extension SharedConfiguration {

	func setConfig(key: String, on: Bool, value: Bool) {
		if var config = configuration[key] as? [String: Any] {
			config["on"] = on
			config["value"] = value
			configuration[key] = config
		}
	}

	func setConfig(key: String, on: Bool, value: Int) {
		if var config = configuration[key] as? [String: Any] {
			config["on"] = on
			config["value"] = value
			configuration[key] = config
		}
	}

	func setConfig(key: String, on: Bool, label: String, value: Int) {
		if var config = configuration[key] as? [String: Any] {
			config["on"] = on
			config["label"] = label
			config["value"] = value
			configuration[key] = config
		}
	}

	func setRule(key: String, on: Bool, value: Bool) {
		if var rule = rules[key] as? [String: Any] {
			rule["on"] = on
			rule["value"] = value
			self.rules[key] = rule
		}
	}
}
