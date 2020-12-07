import Foundation

extension Array {

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
