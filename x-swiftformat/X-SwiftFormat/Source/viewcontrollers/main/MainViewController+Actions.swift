import Cocoa

extension MainViewController {

	@IBAction func appVersionButtonPopover(_ button: NSButton) {
		let width = 200
		let controller = NSViewController()
		let popover = NSPopover()
		self.popover = popover
		controller.view = NSView(frame: NSRect(x: 0, y: 0, width: width, height: 70))
		popover.contentViewController = controller
		popover.contentSize = controller.view.frame.size
		popover.behavior = .semitransient
		popover.animates = true

		let textField = NSTextField(string: "🚀 \(appUpdateVersionName ?? "Version: 1.0")")
		textField.frame = NSRect(x: 10, y: 32, width: width - 20, height: 20)
		textField.isBezeled = false
		textField.drawsBackground = true
		textField.backgroundColor = .clear
		textField.isEditable = false
		textField.isSelectable = false
		textField.alignment = .center
		controller.view.addSubview(textField)

		let downloadVersion = NSButton(frame: NSRect(x: (width - 100) / 2, y: 5, width: 100, height: 32))
		downloadVersion.isBordered = false
		downloadVersion.title = "Download"
		downloadVersion.image = NSImage(named: "default-download-bt")
		downloadVersion.target = self
		downloadVersion.action = #selector(self.appUpdateVersionButtonPress(_:))
		downloadVersion.bezelStyle = .rounded
		controller.view.addSubview(downloadVersion)

		popover.show(relativeTo: .zero, of: button, preferredEdge: .maxY)
	}

	@IBAction func environmentAddPress(_ button: NSButton) {
		guard let window = NSApp.mainWindow else { return }

		let alert = NSAlert()
		alert.alertStyle = .informational
		alert.messageText = "Add Environment"
		alert.informativeText = ""
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")
		let environmentName = NSTextField(frame: NSRect(x: 0, y: 0, width: 228, height: 24))
		environmentName.bezelStyle = .roundedBezel
		environmentName.placeholderString = "Environment name"
		alert.accessoryView = environmentName
		alert.beginSheetModal(for: window) { response in
			if response.rawValue == 1000 && environmentName.stringValue.count > 0 {
				self.sharedConfiguration.setConfiguration(for: environmentName.stringValue)
			}
		}
	}

	@IBAction func environmentRemovePress(_ button: NSButton) {
		guard let window = NSApp.mainWindow else { return }

		let alert = NSAlert()
		alert.alertStyle = .informational
		alert.messageText = "Delete Environment"
		alert.informativeText = "Are you sure?"
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")
		alert.beginSheetModal(for: window) { response in
			if response.rawValue == 1000 {
				self.sharedConfiguration.deleteConfiguration(for: self.sharedConfiguration.environment)
			}
		}
	}

	@IBAction func environmentPopUpButtonPress(_ button: NSPopUpButton) {
		guard let environment = button.selectedItem?.title else { return }
		self.sharedConfiguration.environment = environment
	}

	@IBAction func versionButtonPress(_ button: NSButton) {
		if let url = URL(string: kSwiftFormatURL) {
			NSWorkspace.shared.open(url)
		}
	}

	@IBAction func resetButtonPress(_ button: NSButton) {
		guard let window = NSApp.mainWindow else { return }

		let alert = NSAlert()
		alert.alertStyle = .informational
		alert.messageText = "Reset App"
		alert.informativeText = "Are you sure?"
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")
		alert.beginSheetModal(for: window) { response in
			if response.rawValue == 1000 {
				self.sharedConfiguration.reset()
			}
		}
	}

	@IBAction func previewButtonPress(_ button: NSButton) {
		self.performSegue(withIdentifier: NSStoryboardSegue.Identifier("MAIN_TO_PREVIEW"), sender: nil)
	}

	@objc private func appUpdateVersionButtonPress(_ button: NSButton) {
		popover?.close()
		if let appUpdateVersionButtonURL = appUpdateVersionButtonURL {
			if let url = URL(string: appUpdateVersionButtonURL) {
				NSWorkspace.shared.open(url)
			}
		}
	}
}
