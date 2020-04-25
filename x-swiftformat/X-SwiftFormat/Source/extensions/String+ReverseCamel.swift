//
//  String+ReverseCamel.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension String {

	var reverseCamelCase: String {
		let pattern = "([a-z0-9])([A-Z])"
		let regex = try? NSRegularExpression(pattern: pattern, options: [])
		let range = NSRange(location: 0, length: self.count)
		if let regex = regex {
			return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: "$1 $2").capitalized
		}
		return self
	}
}
