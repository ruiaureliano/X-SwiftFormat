import Cocoa

private let defaultEnvironment: String = "Default Environment"
private let defaultRules: [String: Any] = [
	"AllPublicDeclarationsHaveDocumentation": ["type": "boolean", "on": false, "value": false],
	"AlwaysUseLowerCamelCase": ["type": "boolean", "on": false, "value": true],
	"AmbiguousTrailingClosureOverload": ["type": "boolean", "on": false, "value": true],
	"BeginDocumentationCommentWithOneLineSummary": ["type": "boolean", "on": false, "value": false],
	"DoNotUseSemicolons": ["type": "boolean", "on": false, "value": true],
	"DontRepeatTypeInStaticProperties": ["type": "boolean", "on": false, "value": true],
	"FileScopedDeclarationPrivacy": ["type": "boolean", "on": false, "value": true],
	"FullyIndirectEnum": ["type": "boolean", "on": false, "value": true],
	"GroupNumericLiterals": ["type": "boolean", "on": false, "value": true],
	"IdentifiersMustBeASCII": ["type": "boolean", "on": false, "value": true],
	"NeverForceUnwrap": ["type": "boolean", "on": false, "value": false],
	"NeverUseForceTry": ["type": "boolean", "on": false, "value": false],
	"NeverUseImplicitlyUnwrappedOptionals": ["type": "boolean", "on": false, "value": false],
	"NoAccessLevelOnExtensionDeclaration": ["type": "boolean", "on": false, "value": true],
	"NoBlockComments": ["type": "boolean", "on": false, "value": true],
	"NoCasesWithOnlyFallthrough": ["type": "boolean", "on": false, "value": true],
	"NoEmptyTrailingClosureParentheses": ["type": "boolean", "on": false, "value": true],
	"NoLabelsInCasePatterns": ["type": "boolean", "on": false, "value": true],
	"NoLeadingUnderscores": ["type": "boolean", "on": false, "value": false],
	"NoParensAroundConditions": ["type": "boolean", "on": false, "value": true],
	"NoVoidReturnOnFunctionSignature": ["type": "boolean", "on": false, "value": true],
	"OneCasePerLine": ["type": "boolean", "on": false, "value": true],
	"OneVariableDeclarationPerLine": ["type": "boolean", "on": false, "value": true],
	"OnlyOneTrailingClosureArgument": ["type": "boolean", "on": false, "value": true],
	"OrderedImports": ["type": "boolean", "on": false, "value": true],
	"ReturnVoidInsteadOfEmptyTuple": ["type": "boolean", "on": false, "value": true],
	"UseEarlyExits": ["type": "boolean", "on": false, "value": false],
	"UseLetInEveryBoundCaseVariable": ["type": "boolean", "on": false, "value": true],
	"UseShorthandTypeNames": ["type": "boolean", "on": false, "value": true],
	"UseSingleLinePropertyGetter": ["type": "boolean", "on": false, "value": true],
	"UseSynthesizedInitializer": ["type": "boolean", "on": false, "value": true],
	"UseTripleSlashForDocumentationComments": ["type": "boolean", "on": false, "value": true],
	"UseWhereClausesInForLoops": ["type": "boolean", "on": false, "value": false],
	"ValidateDocumentationComments": ["type": "boolean", "on": false, "value": false],
]

private let defaultConfiguration: [String: Any] = [
	"maximumBlankLines": ["type": "number", "on": false, "key": "maximumBlankLines", "value": 1, "max": 100, "min": 1, "increment": 1],
	"lineLength": ["type": "number", "on": false, "key": "lineLength", "value": 100, "max": 1000, "min": 1, "increment": 10],
	"tabWidth": ["type": "number", "on": false, "key": "tabWidth", "value": 8, "max": 100, "min": 1, "increment": 1],
	"indentation": ["type": "combo_num", "on": false, "key": "indentation", "labels": ["spaces", "tabs"], "label": "space", "value": 2, "max": 100, "min": 1, "increment": 1],
	"respectsExistingLineBreaks": ["type": "boolean", "on": false, "key": "respectsExistingLineBreaks", "value": true],
	"lineBreakBeforeControlFlowKeywords": ["type": "boolean", "on": false, "key": "lineBreakBeforeControlFlowKeywords", "value": false],
	"lineBreakBeforeEachArgument": ["type": "boolean", "on": false, "key": "lineBreakBeforeEachArgument", "value": false],
	"lineBreakBeforeEachGenericRequirement": ["type": "boolean", "on": false, "key": "lineBreakBeforeEachGenericRequirement", "value": false],
	"prioritizeKeepingFunctionOutputTogether": ["type": "boolean", "on": false, "key": "prioritizeKeepingFunctionOutputTogether", "value": false],
	"indentConditionalCompilationBlocks": ["type": "boolean", "on": false, "key": "indentConditionalCompilationBlocks", "value": true],
	"lineBreakAroundMultilineExpressionChainComponents": ["type": "boolean", "on": false, "key": "lineBreakAroundMultilineExpressionChainComponents", "value": false],
	"fileScopedDeclarationPrivacy": ["type": "combo", "on": false, "key": "fileScopedDeclarationPrivacy", "labels": ["private", "fileprivate"], "value": "private"],
	"indentSwitchCaseLabels": ["type": "boolean", "on": false, "key": "indentSwitchCaseLabels", "value": false],
	"rules": defaultRules,
]

class SharedConfiguration: NSObject {

	private var _environment: String = defaultEnvironment
	private var _configurations: [String: [String: Any]] = [defaultEnvironment: defaultConfiguration]

	convenience init(components: [String: Any]) {
		self.init()
		if let environment = components["environment"] as? String {
			self._environment = environment
		}
		if let configurations = components["configurations"] as? [String: [String: Any]] {
			self._configurations = configurations
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
