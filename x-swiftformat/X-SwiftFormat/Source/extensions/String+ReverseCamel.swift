import Foundation

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

	var camelCaseToWords: String {
		return unicodeScalars.dropFirst().reduce(String(prefix(1))) {
			return CharacterSet.uppercaseLetters.contains($1) ? $0 + " " + String($1) : $0 + String($1)
		}
	}
}
