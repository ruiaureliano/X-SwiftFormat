import Cocoa

class XSFDocHandler: NSObject {

	static func readSwiftFormatFile(with url: URL) {

		if let data = try? Data(contentsOf: url), let json = data.json as? [String: Any] {
			var configuration: [String: Any] = [:]
			for entry in json {
				let key = entry.key
				let value = entry.value
				if key != "metadata" {
					configuration[key] = value
				}
			}
			Notifications.shared.postNotification(name: .readXSFFile, object: configuration)
		}
	}
}
