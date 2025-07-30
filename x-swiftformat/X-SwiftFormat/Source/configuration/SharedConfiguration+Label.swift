import Cocoa

extension SharedConfiguration {

	func label(for key: String) -> String {
		let pattern = "([a-z])([A-Z])"
		let separated = key.replacingOccurrences(of: pattern, with: "$1 $2", options: .regularExpression)
		return separated.capitalized
	}
}
