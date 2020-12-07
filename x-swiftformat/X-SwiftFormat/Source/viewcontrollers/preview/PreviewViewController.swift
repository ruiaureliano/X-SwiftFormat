import Cocoa

class PreviewViewController: NSViewController {

	@IBOutlet weak var previewEditor: PreviewEditor!
	@IBOutlet weak var showInvisiblesBt: NSSwitch!
	@IBOutlet weak var previewFormatBtButton: NSButton!

	private var template: String = ""

	override func viewDidLoad() {
		super.viewDidLoad()
		if let filepath = Bundle.main.path(forResource: "sample", ofType: "txt") {
			do {
				self.template = try String(contentsOfFile: filepath)
				self.previewEditor.string = self.template
			} catch {
			}
		}
	}

	override func viewWillAppear() {
		super.viewWillAppear()
		guard let window = self.view.window else { return }
		window.center()
	}

	override func viewDidAppear() {
		super.viewDidAppear()
		guard let window = self.view.window else { return }
		window.isMovableByWindowBackground = true
		window.titlebarAppearsTransparent = true
		window.title = "Person.swift"
		window.backgroundColor = NSColor(named: NSColor.Name("preview-background-color"))
	}
}
