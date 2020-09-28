//
//  Config.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

class Config: NSObject {

	static let rules: [String: Bool] = [
		"AllPublicDeclarationsHaveDocumentation": true,
		"AlwaysUseLowerCamelCase": true,
		"AmbiguousTrailingClosureOverload": true,
		"BeginDocumentationCommentWithOneLineSummary": true,
		"BlankLineBetweenMembers": true,
		"CaseIndentLevelEqualsSwitch": true,
		"DoNotUseSemicolons": true,
		"DontRepeatTypeInStaticProperties": true,
		"FullyIndirectEnum": true,
		"GroupNumericLiterals": true,
		"IdentifiersMustBeASCII": true,
		"MultiLineTrailingCommas": true,
		"NeverForceUnwrap": true,
		"NeverUseForceTry": true,
		"NeverUseImplicitlyUnwrappedOptionals": true,
		"NoAccessLevelOnExtensionDeclaration": true,
		"NoBlockComments": true,
		"NoCasesWithOnlyFallthrough": true,
		"NoEmptyTrailingClosureParentheses": true,
		"NoLabelsInCasePatterns": true,
		"NoLeadingUnderscores": true,
		"NoParensAroundConditions": true,
		"NoVoidReturnOnFunctionSignature": true,
		"OneCasePerLine": true,
		"OneVariableDeclarationPerLine": true,
		"OnlyOneTrailingClosureArgument": true,
		"OrderedImports": true,
		"ReturnVoidInsteadOfEmptyTuple": true,
		"UseEnumForNamespacing": true,
		"UseLetInEveryBoundCaseVariable": true,
		"UseShorthandTypeNames": true,
		"UseSingleLinePropertyGetter": true,
		"UseSynthesizedInitializer": true,
		"UseTripleSlashForDocumentationComments": true,
		"ValidateDocumentationComments": true,
	]

	static let configuration: [[String: Any]] = [
		[
			"type": "number",
			"key": "maximumBlankLines",
			"value": 1,
			"max": 100,
			"min": 1,
			"increment": 1,
		],
		[
			"type": "number",
			"key": "lineLength",
			"value": 100,
			"max": 1000,
			"min": 1,
			"increment": 10,
		],
		[
			"type": "number",
			"key": "tabWidth",
			"value": 8,
			"max": 100,
			"min": 1,
			"increment": 1,
		],
		[
			"type": "object",
			"key": "indentation",
			"options": [
				"spaces",
				"tabs",
			],
			"value": 2,
			"max": 100,
			"min": 1,
			"increment": 1,
		],
		[
			"type": "boolean",
			"key": "respectsExistingLineBreaks",
			"value": true,
		],
		[
			"type": "boolean",
			"key": "lineBreakBeforeControlFlowKeywords",
			"value": false,
		],
		[
			"type": "boolean",
			"key": "lineBreakBeforeEachArgument",
			"value": false,
		],
		[
			"type": "boolean",
			"key": "lineBreakBeforeEachGenericRequirement",
			"value": false,
		],
		[
			"type": "boolean",
			"key": "prioritizeKeepingFunctionOutputTogether",
			"value": false,
		],
		[
			"type": "boolean",
			"key": "indentConditionalCompilationBlocks",
			"value": true,
		],
	]
}
