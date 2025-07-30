import Cocoa

#warning("MISSING: reflowMultilineStringLiterals")
#warning("MISSING: noAssignmentInExpressions")

extension SharedConfiguration {

	var defaultConfiguration: [String: Any] {
		return [
			"fileScopedDeclarationPrivacy": [
				"type": "combo",
				"on": false,
				"key": "fileScopedDeclarationPrivacy",
				"labels": [
					"private",
					"fileprivate",
				],
				"value": "private",
			],
			"indentBlankLines": [
				"type": "boolean",
				"on": false,
				"key": "indentBlankLines",
				"value": false,
			],
			"indentConditionalCompilationBlocks": [
				"type": "boolean",
				"on": false,
				"key": "indentConditionalCompilationBlocks",
				"value": true,
			],
			"indentSwitchCaseLabels": [
				"type": "boolean",
				"on": false,
				"key": "indentSwitchCaseLabels",
				"value": false,
			],
			"indentation": [
				"type": "combo_num",
				"on": false,
				"key": "indentation",
				"labels": [
					"spaces",
					"tabs",
				],
				"label": "space",
				"value": 2,
				"max": 100,
				"min": 1,
				"increment": 1,
			],
			"lineBreakAroundMultilineExpressionChainComponents": [
				"type": "boolean",
				"on": false,
				"key": "lineBreakAroundMultilineExpressionChainComponents",
				"value": false,
			],
			"lineBreakBeforeControlFlowKeywords": [
				"type": "boolean",
				"on": false,
				"key": "lineBreakBeforeControlFlowKeywords",
				"value": false,
			],
			"lineBreakBeforeEachArgument": [
				"type": "boolean",
				"on": false,
				"key": "lineBreakBeforeEachArgument",
				"value": false,
			],
			"lineBreakBeforeEachGenericRequirement": [
				"type": "boolean",
				"on": false,
				"key": "lineBreakBeforeEachGenericRequirement",
				"value": false,
			],
			"lineBreakBetweenDeclarationAttributes": [
				"type": "boolean",
				"on": false,
				"key": "lineBreakBetweenDeclarationAttributes",
				"value": false,
			],
			"lineLength": [
				"type": "number",
				"on": false,
				"key": "lineLength",
				"value": 100,
				"max": 1000,
				"min": 1,
				"increment": 10,
			],
			"maximumBlankLines": [
				"type": "number",
				"on": false,
				"key": "maximumBlankLines",
				"value": 1,
				"max": 100,
				"min": 1,
				"increment": 1,
			],
			"multiElementCollectionTrailingCommas": [
				"type": "boolean",
				"on": false,
				"key": "multiElementCollectionTrailingCommas",
				"value": true,
			],
			"prioritizeKeepingFunctionOutputTogether": [
				"type": "boolean",
				"on": false,
				"key": "prioritizeKeepingFunctionOutputTogether",
				"value": false,
			],
			"respectsExistingLineBreaks": [
				"type": "boolean",
				"on": false,
				"key": "respectsExistingLineBreaks",
				"value": true,
			],
			"rules": defaultRules,
			"spacesAroundRangeFormationOperators": [
				"type": "boolean",
				"on": false,
				"key": "spacesAroundRangeFormationOperators",
				"value": false,
			],
			"spacesBeforeEndOfLineComments": [
				"type": "number",
				"on": false,
				"key": "spacesBeforeEndOfLineComments",
				"value": 2,
				"max": 100,
				"min": 0,
				"increment": 1,
			],
			"tabWidth": [
				"type": "number",
				"on": false,
				"key": "tabWidth",
				"value": 8,
				"max": 100,
				"min": 1,
				"increment": 1,
			],
		]
	}
}
