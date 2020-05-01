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
		NotificationCenter.default.addObserver(self, selector: #selector(self.readXSFFileNotification(notification:)), name: kReadXSFFileNotification, object: nil)
	}

	@objc func userDefaultsChangedNotification(notification: Notification) {
		previewWindow.setConfiguration(configuration: tabViewConfiguration.sharedConfiguration, rules: tabViewRules.sharedRules)
	}

	@objc func readXSFFileNotification(notification: Notification) {
		previewWindow.setConfiguration(configuration: tabViewConfiguration.sharedConfiguration, rules: tabViewRules.sharedRules)
		tabViewConfiguration.reloadDataSource()
		tabViewRules.reloadDataSource()
	}

	func applicationDidBecomeActive(_ notification: Notification) {
		changeApplicationIconImage()
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

	func application(_ sender: NSApplication, openFiles filenames: [String]) {
		XSFDocHandler.handle(filenames: filenames)
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

	func exportConfigurationFile() {
		let savePanel = NSSavePanel()
		savePanel.canCreateDirectories = true
		savePanel.showsTagField = false
		savePanel.nameFieldStringValue = "swift-format-configuration.\(XSFDocType.config.rawValue)"

		savePanel.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1 {
				if let url = savePanel.url {
					var configuration: [String: Any] = [:]
					for entry in UserDefaults.configuration {
						configuration[entry.key] = entry.value
					}
					var metadata: [String: String] = ["type": "configuration"]
					if let version = Bundle.main.CFBundleShortVersionString {
						metadata["version"] = version
					}
					if let build = Bundle.main.CFBundleVersion {
						metadata["build"] = build
					}
					configuration["metadata"] = metadata
					if let json = configuration.jsonPretty {
						try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
					}
				}
			}
		}
	}

	func exportRulesFile() {
		let savePanel = NSSavePanel()
		savePanel.canCreateDirectories = true
		savePanel.showsTagField = false
		savePanel.nameFieldStringValue = "swift-format-rules.\(XSFDocType.rules.rawValue)"
		savePanel.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1 {
				if let url = savePanel.url {
					var rules: [String: Any] = [:]
					for entry in UserDefaults.rules {
						rules[entry.key] = entry.value
					}
					var metadata: [String: String] = ["type": "rules"]
					if let version = Bundle.main.CFBundleShortVersionString {
						metadata["version"] = version
					}
					if let build = Bundle.main.CFBundleVersion {
						metadata["build"] = build
					}
					rules["metadata"] = metadata
					if let json = rules.jsonPretty {
						try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
					}
				}
			}
		}
	}

	func exportSwiftFormatFile() {
		let savePanel = NSSavePanel()
		savePanel.canCreateDirectories = true
		savePanel.showsTagField = false
		savePanel.nameFieldStringValue = ".swift-format"
		savePanel.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1 {
				if let url = savePanel.url {
					var swiftformat: [String: Any] = UserDefaults.configuration
					if UserDefaults.rules.count > 0 {
						swiftformat["rules"] = UserDefaults.rules
					}
					if let json = swiftformat.jsonPretty {
						try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
					}
				}
			}
		}
	}

	func exportConfigurationOrRulesFile() {
		var tabOption: TabOption = .configuration
		if let selectedTabViewItem = tabView.selectedTabViewItem {
			if let option = TabOption(rawValue: selectedTabViewItem.label) {
				tabOption = option
			}
		}
		let savePanel = NSSavePanel()
		savePanel.canCreateDirectories = true
		savePanel.showsTagField = false
		switch tabOption {
		case .configuration:
			savePanel.nameFieldStringValue = "swift-format-configuration.\(XSFDocType.config.rawValue)"
		case .rules:
			savePanel.nameFieldStringValue = "swift-format-rules.\(XSFDocType.rules.rawValue)"
		}
		savePanel.beginSheetModal(for: self.window) { (response) in
			if response.rawValue == 1 {
				if let url = savePanel.url {
					switch tabOption {
					case .configuration:
						var configuration: [String: Any] = [:]
						for entry in UserDefaults.configuration {
							configuration[entry.key] = entry.value
						}
						var metadata: [String: String] = ["type": "configuration"]
						if let version = Bundle.main.CFBundleShortVersionString {
							metadata["version"] = version
						}
						if let build = Bundle.main.CFBundleVersion {
							metadata["build"] = build
						}
						configuration["metadata"] = metadata
						if let json = configuration.jsonPretty {
							try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
						}
					case .rules:
						var rules: [String: Any] = [:]
						for entry in UserDefaults.rules {
							rules[entry.key] = entry.value
						}
						var metadata: [String: String] = ["type": "rules"]
						if let version = Bundle.main.CFBundleShortVersionString {
							metadata["version"] = version
						}
						if let build = Bundle.main.CFBundleVersion {
							metadata["build"] = build
						}
						rules["metadata"] = metadata
						if let json = rules.jsonPretty {
							try? json.write(to: url, atomically: true, encoding: String.Encoding.utf8)
						}
					}
				}
			}
		}
	}
}
