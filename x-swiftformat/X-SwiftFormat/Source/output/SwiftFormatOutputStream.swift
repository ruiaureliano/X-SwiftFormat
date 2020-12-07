import Cocoa

struct SwiftFormatOutputStream: TextOutputStream {

	var output: String?

	mutating func write(_ string: String) {
		self.output = string
	}
}
