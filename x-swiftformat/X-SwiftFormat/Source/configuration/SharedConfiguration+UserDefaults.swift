import Cocoa

private let kUserDefaultsSharedSuiteName = "group.com.ruiaureliano.xswiftformat"
private let kUserDefaultsSharedConfiguration = "kUserDefaultsSharedConfiguration"

extension SharedConfiguration {

	func saveConfiguration() {
		guard let defaults = UserDefaults(suiteName: kUserDefaultsSharedSuiteName) else { return }
		defaults.set(self.components, forKey: kUserDefaultsSharedConfiguration)
		defaults.synchronize()
	}

	static func loadConfiguration() -> SharedConfiguration {
		guard
			let defaults = UserDefaults(suiteName: kUserDefaultsSharedSuiteName),
			let components = defaults.object(forKey: kUserDefaultsSharedConfiguration) as? [String: Any]
		else {
			return SharedConfiguration()
		}
		return SharedConfiguration(components: components)
	}
}
