import Cocoa

class XSFDocHandler: NSObject {

	static func handle(filenames: [String]) {
		for filename in filenames {
			let components = filename.split(separator: "/")
			if let last = components.last {
				let split = last.split(separator: ".")
				if split.count == 2 {
					if let docType = XSFDocType(rawValue: String(split[1]).lowercased()) {
						switch docType {
						case .swiftformat:
							readSwiftFormatFile(with: URL(fileURLWithPath: filename))
						}
					}
				}
			}
		}
	}

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
