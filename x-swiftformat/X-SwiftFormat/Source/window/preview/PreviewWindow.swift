//
//  PreviewWindow.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa
import SwiftFormat
import SwiftFormatConfiguration

class PreviewWindow: NSWindow {

	var superWindow: NSWindow!

	@IBOutlet weak var previewEditor: PreviewEditor!
	@IBOutlet weak var showInvisiblesBt: NSSwitch!
	@IBOutlet weak var previewFormatBtButton: NSButton!

	private var sharedConfiguration: [String: Any] = [:]
	private var sharedRules: [String: Bool] = [:]

	private var template: String = ""

	override func awakeFromNib() {
		super.awakeFromNib()
		self.isMovableByWindowBackground = true
		if let filepath = Bundle.main.path(forResource: "sample", ofType: "txt") {
			do {
				self.template = try String(contentsOfFile: filepath)
				self.previewEditor.string = self.template
			} catch {
			}
		}
	}

	func setConfiguration(configuration: [String: Any], rules: [String: Bool]) {
		self.sharedConfiguration = configuration
		self.sharedRules = rules
	}

	func openWithConfiguration(configuration: [String: Any], rules: [String: Bool]) {
		self.sharedConfiguration = configuration
		self.sharedRules = rules
		self.previewEditor.string = self.template
		self.previewEditor.syntaxHighlighted()
	}

	@IBAction func showInvisiblesBtPress(_ _switch: NSSwitch) {
		if let layoutManager = previewEditor.layoutManager as? PreviewEditorLayoutManager {
			let drawInvisibles = (_switch.state == .on)
			layoutManager.drawInvisibles = drawInvisibles
			previewEditor.needsDisplay = true
		}
	}

	@IBAction func previewFormatBtPress(_ button: NSButton) {

		var configuration = Configuration.buildConfiguration(with: sharedConfiguration)
		for rule in sharedRules {
			configuration.rules[rule.key] = rule.value
		}

		let swiftFormatter = SwiftFormatter(configuration: configuration)
		var swiftFormatOutputStream = SwiftFormatOutputStream()

		do {
			try swiftFormatter.format(source: self.previewEditor.string, assumingFileURL: nil, to: &swiftFormatOutputStream)
			if let output = swiftFormatOutputStream.output {
				self.previewEditor.string = output
			}
		} catch {
			let alert = NSAlert()
			alert.messageText = "Error"
			alert.informativeText = error.localizedDescription
			alert.alertStyle = .critical
			alert.addButton(withTitle: "OK")
			alert.beginSheetModal(for: self) { (_) in
			}
		}
	}
}
