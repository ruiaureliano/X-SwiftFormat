import Cocoa

typealias NotificationCompletion = (_ object: Any?) -> Void

enum NotificationName: String {
	case didBecomeActive
	case didResignActive
	case environmentDidChanged
	case environmentNeedsReload
	case readXSFFile
}

class Notifications: NSObject {

	private var completions: [NotificationName: NotificationCompletion] = [:]
	static let shared = Notifications()

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	func observe(name: NotificationName, completion: @escaping NotificationCompletion) {
		completions[name] = completion
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(kvo(notification:)), name: NSNotification.Name(rawValue: name.rawValue), object: nil)
	}

	func postNotification(name: NotificationName, object: Any?, after: TimeInterval = 0) {
		DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + after) {
			NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object, userInfo: ["name": name])
		}
	}

	func removeObservers(for name: NotificationName) {
		completions.removeValue(forKey: name)
		NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: name.rawValue), object: nil)
	}

	@objc private func kvo(notification: NSNotification) {
		if let name = notification.userInfo?["name"] as? NotificationName, let completion = completions[name] {
			completion(notification.object)
		}
	}
}
