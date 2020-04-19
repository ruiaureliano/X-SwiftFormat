//
//  Data+JSON.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension Data {

	var json: Any? {
		do {
			return try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
		} catch _ {
		}
		return nil
	}
}
