import Cocoa
import TelemetryDeck

var sherlog = Sherlog.self

private let kTelemetryAppId = "D0AE4EB9-8323-429A-AA5B-669AD0E45F6A"
private let kTelemetryAppNamespace = "com.ruiaureliano"

@main class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ notification: Notification) {
		/* TELEMETRY SDK */
		let config = TelemetryDeck.Config(appID: kTelemetryAppId, namespace: kTelemetryAppNamespace)
		TelemetryDeck.initialize(config: config)
	}

	func applicationWillTerminate(_ notification: Notification) {
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		Notifications.shared.postNotification(name: .didBecomeActive, object: nil)
	}

	func applicationDidResignActive(_ notification: Notification) {
		Notifications.shared.postNotification(name: .didResignActive, object: nil)
	}

	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
		if let window = NSApp.windows.first {
			if !window.isMainWindow || !window.isKeyWindow {
				window.makeKeyAndOrderFront(self)
			}
		}
		return true
	}
}
