import Cocoa

private let defaultEnvironment: String = "Default Environment"

class SharedConfiguration: NSObject {

	private var _environment: String = defaultEnvironment
	private var _configurations: [String: [String: Any]] = [:]

	convenience init(components: [String: Any]) {
		self.init()
		if let environment = components["environment"] as? String, environment.count > 0 {
			self._environment = environment
		} else {
			self._environment = defaultEnvironment
		}
		if let configurations = components["configurations"] as? [String: [String: Any]] {
			self._configurations = configurations
		} else {
			self._configurations = [defaultEnvironment: defaultConfiguration]
		}
	}

	var components: [String: Any] {
		return ["environment": _environment, "configurations": _configurations]
	}

	var environment: String {
		get {
			return _environment
		}
		set {
			_environment = newValue
			saveConfiguration()
			Notifications.shared.postNotification(name: .environmentNeedsReload, object: self)
		}
	}

	var environments: [String] {
		return Array(_configurations.keys)
	}

	var configuration: [String: Any] {
		get {
			guard let configuration = _configurations[_environment] else {
				return defaultConfiguration.filter { key, _ in
					return key != "rules"
				}
			}
			return configuration.filter { key, _ in
				return key != "rules"
			}
		}
		set {
			_configurations[_environment] = newValue
			saveConfiguration()
			Notifications.shared.postNotification(name: .environmentDidChanged, object: self)
		}
	}

	var configurationKeys: [String] {
		return Array(configuration.keys).filter { $0 != "rules" }.sorted()
	}

	var rules: [String: Any] {
		get {
			guard let configuration = _configurations[_environment], let rules = configuration["rules"] as? [String: Any] else {
				return defaultRules
			}
			return rules
		}
		set {
			configuration["rules"] = newValue
		}
	}

	var rulesKeys: [String] {
		return Array(rules.keys).sorted()
	}

	var payload: [String: Any] {
		var config: [String: Any] = [:]
		guard let configuration = _configurations[environment] else {
			return config
		}
		for item in configuration {
			let key = item.key
			if let value = item.value as? [String: Any], let type = value["type"] as? String {
				if type == "boolean" {
					if let on = value["on"] as? Bool, let value = value["value"] as? Bool, on {
						config[key] = value
					}
				} else if type == "number" {
					if let on = value["on"] as? Bool, let value = value["value"] as? Int, on {
						config[key] = value
					}
				} else if type == "combo_num" {
					if let on = value["on"] as? Bool, let label = value["label"] as? String, let value = value["value"] as? Int, on {
						config[key] = [label: value]
					}
				} else if type == "combo" {
					if let on = value["on"] as? Bool, let value = value["value"] as? String, on {
						config[key] = value
					}
				}
			}
		}

		var configRules: [String: Any] = [:]
		for item in rules {
			let key = item.key
			if let value = item.value as? [String: Any], let type = value["type"] as? String {
				if type == "boolean" {
					if let on = value["on"] as? Bool, let value = value["value"] as? Bool, on {
						configRules[key] = value
					}
				}
			}
		}
		if configRules.count > 0 {
			config["rules"] = configRules
		}
		return config
	}

	func reset() {
		_environment = defaultEnvironment
		_configurations = [defaultEnvironment: defaultConfiguration]
		saveConfiguration()
		Notifications.shared.postNotification(name: .environmentNeedsReload, object: self)
	}

	func setConfiguration(configuration: [String: Any]? = nil, for name: String) {
		var n = name
		var i = 1
		while environments.contains(n) {
			n = "\(name) (\(i))"
			i += 1
		}
		_configurations[n] = defaultConfiguration
		_environment = n
		saveConfiguration()

		if let configuration = configuration {
			for item in configuration.filter({ k, _ in return k != "rules" }) {
				let key = item.key
				if let boolValue = item.value as? Bool {
					setConfig(key: key, on: true, value: boolValue)
				} else if let intValue = item.value as? Int {
					setConfig(key: key, on: true, value: intValue)
				} else if let objectValue = item.value as? [String: Int] {
					for item in objectValue {
						setConfig(key: key, on: true, label: item.key, value: item.value)
					}
				}
			}

			if let rules = configuration["rules"] as? [String: Bool] {
				for rule in rules {
					setRule(key: rule.key, on: true, value: rule.value)
				}
			}
		}
		Notifications.shared.postNotification(name: .environmentNeedsReload, object: self)
	}

	func deleteConfiguration(for name: String) {
		_configurations.removeValue(forKey: name)
		_environment = defaultEnvironment
		saveConfiguration()
		Notifications.shared.postNotification(name: .environmentNeedsReload, object: self)
	}
}
