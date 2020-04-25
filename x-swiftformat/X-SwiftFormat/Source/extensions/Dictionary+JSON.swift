//
//  Dictionary+JSON.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

extension Dictionary {

	var json: String? {
		do {
			let data = try JSONSerialization.data(withJSONObject: self, options: [])
			return String(data: data, encoding: .utf8)
		} catch {
		}
		return nil
	}

	var jsonPretty: String? {
		do {
			let data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
			return String(data: data, encoding: .utf8)
		} catch {
		}
		return nil
	}

	var jsonData: Data? {
		do {
			return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
		} catch {
		}
		return nil
	}
}
