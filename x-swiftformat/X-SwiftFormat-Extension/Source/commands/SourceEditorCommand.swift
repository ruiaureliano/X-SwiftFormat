//
//  SourceEditorCommand.swift
//  X-SwiftFormat-Extension
//
//  Created by Rui Aureliano on 01/04/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Foundation
import SwiftFormat
import SwiftFormatConfiguration
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

	let supportedUTIs = [
		"public.swift-source",
		"com.apple.dt.playground",
		"com.apple.dt.playgroundpage",
		"com.apple.dt.swiftpm-package-manifest",
	]

	func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {
		let uti = invocation.buffer.contentUTI
		if supportedUTIs.contains(uti) {
			formatBuffer(with: invocation) { error in
				DispatchQueue.main.async {
					if let swiftFormatError = error as? SwiftFormatError {
						switch swiftFormatError {
						case .fileNotReadable:
							completionHandler(NSError(domain: "The requested file was not readable or it did not exist.", code: -1002, userInfo: nil) as Error)
						case .isDirectory:
							completionHandler(NSError(domain: "The requested file was a directory.", code: -1003, userInfo: nil) as Error)
						case .fileContainsInvalidSyntax(let position):
							completionHandler(
								NSError(domain: "The file contains invalid or unrecognized Swift syntax and cannot be handled safely. (Position: \(position.utf8Offset))", code: -1004, userInfo: nil) as Error)
						}
					} else {
						completionHandler(error)
					}
				}
			}
		} else {
			completionHandler(NSError(domain: "Not a Swift file", code: -1001, userInfo: nil) as Error)
		}
	}

	private func formatBuffer(with invocation: XCSourceEditorCommandInvocation, completion: @escaping (_ error: Error?) -> Void) {
		DispatchQueue.global(qos: .background).async {

			let sharedConfiguration = UserDefaults.configuration
			let sharedRules = UserDefaults.rules

			var configuration = Configuration.buildConfiguration(with: sharedConfiguration)
			for rule in sharedRules {
				configuration.rules[rule.key] = rule.value
			}

			let swiftFormatter = SwiftFormatter(configuration: configuration)
			var swiftFormatOutputStream = SwiftFormatOutputStream()

			do {
				try swiftFormatter.format(source: invocation.buffer.completeBuffer, assumingFileURL: nil, to: &swiftFormatOutputStream)
				if let output = swiftFormatOutputStream.output {
					if invocation.buffer.completeBuffer != output {
						invocation.buffer.completeBuffer = output
					}
				}
				completion(nil)
			} catch {
				completion(error)
			}
		}
	}
}
