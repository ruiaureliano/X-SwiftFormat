//
//  SourceEditorCommand.swift
//  X-SwiftFormat-Extension
//
//  Created by Rui Aureliano on 01/04/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Foundation
import XcodeKit
import SwiftFormat
import SwiftFormatConfiguration

private let kErrorNotSwift = NSError(domain: "Not a Swift file", code: -1001, userInfo: nil)

class SourceEditorCommand: NSObject, XCSourceEditorCommand {

    let supportedUTIs = [
        "public.swift-source",
        "com.apple.dt.playground",
        "com.apple.dt.playgroundpage",
        "com.apple.dt.swiftpm-package-manifest"
    ]

    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void) {

        let uti = invocation.buffer.contentUTI
        if supportedUTIs.contains(uti) {
            let lines = invocation.buffer.lines
            let completeBuffer = invocation.buffer.completeBuffer

            let sharedConfiguration = UserDefaults.configuration
            let sharedRules = UserDefaults.rules

            var configuration = Configuration.buildConfiguration(with: sharedConfiguration)
            for rule in sharedRules {
                configuration.rules[rule.key] = rule.value
            }

            let swiftFormatter = SwiftFormatter(configuration: configuration)
            var swiftFormatOutputStream = SwiftFormatOutputStream()

            do {
                try swiftFormatter.format(source: completeBuffer, assumingFileURL: nil, to: &swiftFormatOutputStream)
                if let output = swiftFormatOutputStream.output {
                    lines.removeAllObjects()
                    lines.add(output)
                    completionHandler(nil)
                }
            } catch {
                completionHandler(error)
            }
        } else {
            completionHandler(kErrorNotSwift as Error)
        }
    }
}
