import Cocoa

var sherlog = Sherlog.self

@main class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ notification: Notification) {
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
