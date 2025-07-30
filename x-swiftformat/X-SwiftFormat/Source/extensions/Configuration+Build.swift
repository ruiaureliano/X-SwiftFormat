import Cocoa
import SwiftFormat

extension Configuration {

	static func buildConfiguration(with payload: [String: Any]) -> Configuration {
		var configuration = Configuration()

		if let maximumBlankLines = payload["maximumBlankLines"] as? Int {
			configuration.maximumBlankLines = maximumBlankLines
		}
		if let lineLength = payload["lineLength"] as? Int {
			configuration.lineLength = lineLength
		}
		if let tabWidth = payload["tabWidth"] as? Int {
			configuration.tabWidth = tabWidth
		}
		if let indentation = payload["indentation"] as? [String: Any] {
			if let spaces = indentation["spaces"] as? Int {
				configuration.indentation = Indent.spaces(spaces)
			} else if let tabs = indentation["tabs"] as? Int {
				configuration.indentation = Indent.tabs(tabs)
			}
		}
		if let respectsExistingLineBreaks = payload["respectsExistingLineBreaks"] as? Bool {
			configuration.respectsExistingLineBreaks = respectsExistingLineBreaks
		}
		if let lineBreakBeforeControlFlowKeywords = payload["lineBreakBeforeControlFlowKeywords"] as? Bool {
			configuration.lineBreakBeforeControlFlowKeywords = lineBreakBeforeControlFlowKeywords
		}
		if let lineBreakBeforeEachArgument = payload["lineBreakBeforeEachArgument"] as? Bool {
			configuration.lineBreakBeforeEachArgument = lineBreakBeforeEachArgument
		}
		if let lineBreakBeforeEachGenericRequirement = payload["lineBreakBeforeEachGenericRequirement"] as? Bool {
			configuration.lineBreakBeforeEachGenericRequirement = lineBreakBeforeEachGenericRequirement
		}
		if let prioritizeKeepingFunctionOutputTogether = payload["prioritizeKeepingFunctionOutputTogether"] as? Bool {
			configuration.prioritizeKeepingFunctionOutputTogether = prioritizeKeepingFunctionOutputTogether
		}
		if let indentConditionalCompilationBlocks = payload["indentConditionalCompilationBlocks"] as? Bool {
			configuration.indentConditionalCompilationBlocks = indentConditionalCompilationBlocks
		}
		if let lineBreakAroundMultilineExpressionChainComponents = payload["lineBreakAroundMultilineExpressionChainComponents"] as? Bool {
			configuration.lineBreakAroundMultilineExpressionChainComponents = lineBreakAroundMultilineExpressionChainComponents
		}
		if let lineBreakAroundMultilineExpressionChainComponents = payload["lineBreakAroundMultilineExpressionChainComponents"] as? Bool {
			configuration.lineBreakAroundMultilineExpressionChainComponents = lineBreakAroundMultilineExpressionChainComponents
		}
		if let fileScopedDeclarationPrivacy = payload["fileScopedDeclarationPrivacy"] as? String {
			if fileScopedDeclarationPrivacy == "fileprivate" {
				configuration.fileScopedDeclarationPrivacy.accessLevel = .fileprivate
			} else {
				configuration.fileScopedDeclarationPrivacy.accessLevel = .private
			}
		}
		if let indentSwitchCaseLabels = payload["indentSwitchCaseLabels"] as? Bool {
			configuration.indentSwitchCaseLabels = indentSwitchCaseLabels
		}

		if let rules = payload["rules"] as? [String: Bool] {
			for rule in rules {
				configuration.rules[rule.key] = rule.value
			}
		}
		return configuration
	}
}
