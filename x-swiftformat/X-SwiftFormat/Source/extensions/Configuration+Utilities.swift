//
//  Configuration+Utilities.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa
import SwiftFormatConfiguration

extension Configuration {

	static func buildConfiguration(with configuration: [String: Any]) -> Configuration {
		var _configuration = Configuration()
		if let maximumBlankLines = configuration["maximumBlankLines"] as? Int {
			_configuration.maximumBlankLines = maximumBlankLines
		}
		if let lineLength = configuration["lineLength"] as? Int {
			_configuration.lineLength = lineLength
		}
		if let tabWidth = configuration["tabWidth"] as? Int {
			_configuration.tabWidth = tabWidth
		}
		if let indentation = configuration["indentation"] as? [String: Any] {
			if let spaces = indentation["spaces"] as? Int {
				_configuration.indentation = Indent.spaces(spaces)
			} else if let tabs = indentation["tabs"] as? Int {
				_configuration.indentation = Indent.tabs(tabs)
			}
		}
		if let respectsExistingLineBreaks = configuration["respectsExistingLineBreaks"] as? Bool {
			_configuration.respectsExistingLineBreaks = respectsExistingLineBreaks
		}
		if let lineBreakBeforeControlFlowKeywords = configuration["lineBreakBeforeControlFlowKeywords"] as? Bool {
			_configuration.lineBreakBeforeControlFlowKeywords = lineBreakBeforeControlFlowKeywords
		}
		if let lineBreakBeforeEachArgument = configuration["lineBreakBeforeEachArgument"] as? Bool {
			_configuration.lineBreakBeforeEachArgument = lineBreakBeforeEachArgument
		}
		if let lineBreakBeforeEachGenericRequirement = configuration["lineBreakBeforeEachGenericRequirement"] as? Bool {
			_configuration.lineBreakBeforeEachGenericRequirement = lineBreakBeforeEachGenericRequirement
		}
		if let prioritizeKeepingFunctionOutputTogether = configuration["prioritizeKeepingFunctionOutputTogether"] as? Bool {
			_configuration.prioritizeKeepingFunctionOutputTogether = prioritizeKeepingFunctionOutputTogether
		}
		if let indentConditionalCompilationBlocks = configuration["indentConditionalCompilationBlocks"] as? Bool {
			_configuration.indentConditionalCompilationBlocks = indentConditionalCompilationBlocks
		}
		if let lineBreakAroundMultilineExpressionChainComponents = configuration["lineBreakAroundMultilineExpressionChainComponents"] as? Bool {
			_configuration.lineBreakAroundMultilineExpressionChainComponents = lineBreakAroundMultilineExpressionChainComponents
		}
		return _configuration
	}
}
