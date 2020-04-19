//
//  SwiftFormatOutputStream.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

struct SwiftFormatOutputStream: TextOutputStream {

	var output: String?

	mutating func write(_ string: String) {
		self.output = string
	}
}
