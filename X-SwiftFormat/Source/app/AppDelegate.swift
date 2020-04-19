//
//  AppDelegate.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 30/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

@NSApplicationMain class AppDelegate: NSObject, NSApplicationDelegate {

	@IBOutlet weak var previewWindow: PreviewWindow!
	@IBOutlet weak var window: NSWindow!

	@IBOutlet weak var appIcon: NSImageView!
	@IBOutlet weak var appName: NSTextField!
	@IBOutlet weak var appVersion: NSTextField!
	@IBOutlet weak var appVersionButton: NSButton!
	var appVersionName: String?
	var appVersionButtonURL: String?

	@IBOutlet weak var tabView: NSTabView!
	@IBOutlet weak var tabViewConfiguration: TabConfigurationView!
	@IBOutlet weak var tabViewRules: TabRulesView!

	@IBOutlet weak var versionButton: NSButton!
	@IBOutlet weak var resetButton: NSButton!
	@IBOutlet weak var previewButton: NSButton!

	var popover: NSPopover?
	private var effectiveAppearanceObservation: NSKeyValueObservation?

	func applicationDidFinishLaunching(_ aNotification: Notification) {

		changeApplicationIconImage()

		window.isMovableByWindowBackground = true
		previewWindow.superWindow = window

		tabView.delegate = self

		if let shortVersionString = Bundle.main.CFBundleShortVersionString, let version = Bundle.main.CFBundleVersion {
			appVersion.stringValue = "Version: \(shortVersionString) (\(version))"
		}
		if let executable = Bundle.main.CFBundleExecutable {
			appName.stringValue = executable
		}

		versionButton.title = kSwiftFormatName

		if let contentView = window.contentView {
			effectiveAppearanceObservation = contentView.observe(\.effectiveAppearance) { [weak self] _, _ in
				self?.changeApplicationIconImage()
			}
		}
		NotificationCenter.default.addObserver(self, selector: #selector(self.userDefaultsChangedNotification(notification:)), name: kUserDefaultsChangedNotification, object: nil)
	}

	@objc func userDefaultsChangedNotification(notification: Notification) {
		previewWindow.setConfiguration(configuration: tabViewConfiguration.sharedConfiguration, rules: tabViewRules.sharedRules)
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		changeApplicationIconImage()
		checkForNewVersion()
	}

	func applicationDidResignActive(_ notification: Notification) {
		popover?.close()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
	}

	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
		if !window.isMainWindow || !window.isKeyWindow {
			window.makeKeyAndOrderFront(self)
		}
		return true
	}

	func changeApplicationIconImage() {
		if let iconOverlay = NSImage(named: "app-icon-overlay") {
			if let iconOverlayCopy = iconOverlay.copy() as? NSImage {
				if let icon = AppIcon.with(image: iconOverlayCopy, with: .selectedContentBackgroundColor) {
					NSApp.applicationIconImage = icon
				}
			}
		}
	}

	func checkForNewVersion() {
		if let url = URL(string: kXSwiftFormatReleases) {
			let request = URLRequest(url: url)
			let task = URLSession.shared.dataTask(with: request) { data, _, _ in
				if let data = data {
					if let releases = data.json as? [[String: Any]] {
						if let release = releases.first {
							if let name = release["name"] as? String,
								let tagName = release["tag_name"] as? String,
								let publishedAt = release["published_at"] as? String,
								let assets = release["assets"] as? [[String: Any]] {
								if let asset = assets.first {
									if let browserDownloadURL = asset["browser_download_url"] as? String {
										self.validateNewVersion(
											name: name,
											tagName: tagName,
											publishedAt: publishedAt,
											browserDownloadURL: browserDownloadURL
										)
									}
								}
							}
						}
					}
				}
			}
			task.resume()
		}
	}

	private func validateNewVersion(name: String, tagName: String, publishedAt: String, browserDownloadURL: String) {
		if let version = Bundle.main.CFBundleVersion {
			switch version.compare(tagName, options: .numeric, range: nil, locale: nil) {
			case .orderedAscending:
				DispatchQueue.main.async {
					self.appVersionName = name
					self.appVersionButtonURL = browserDownloadURL
					self.appVersionButton.isEnabled = true
					self.appVersionButton.isHidden = false
				}
			case .orderedSame:
				break
			case .orderedDescending:
				break
			}
		}
	}
}
