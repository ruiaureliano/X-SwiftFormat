import Foundation

public struct SherlogLevel: OptionSet {

	public var rawValue: Int
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
	public static let info = SherlogLevel(rawValue: 1 << 0)
	public static let warning = SherlogLevel(rawValue: 1 << 1)
	public static let error = SherlogLevel(rawValue: 1 << 2)
	public static let all: SherlogLevel = [.info, .warning, .error]
}

public struct SherlogPrint: OptionSet {

	public var rawValue: Int
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
	public static let date = SherlogPrint(rawValue: 1 << 0)
	public static let file = SherlogPrint(rawValue: 1 << 1)
	public static let function = SherlogPrint(rawValue: 1 << 2)
	public static let line = SherlogPrint(rawValue: 1 << 3)
	public static let message = SherlogPrint(rawValue: 1 << 4)
	public static let all: SherlogPrint = [.date, .file, .function, .line, .message]
}

public struct SherlogEnvironment: OptionSet {

	public var rawValue: Int
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}
	public static let debug = SherlogEnvironment(rawValue: 1 << 0)
	public static let release = SherlogEnvironment(rawValue: 1 << 1)
	public static let all: SherlogEnvironment = [.debug, .release]
}

open class Sherlog: NSObject {

	public static var version: String = "1.0"
	public static var level: SherlogLevel = [.warning, .error]
	public static var print: SherlogPrint = [.date, .message]
	public static var environment: SherlogEnvironment = .debug
	public static var dateFormat: String = "YYYY-MM-dd HH:mm:ss"

	open class func log(_ message: Any, level: SherlogLevel = .info, file: String = #fileID, function: String = #function, line: Int = #line) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat
		let dateString = dateFormatter.string(from: Date())

		if self.level.contains(level) {
			var log = color(level: level)
			if self.print.contains(.date) {
				log.append("\(dateString) ▶︎")
			}
			if self.print.contains(.file) {
				log.append(" [file: \(file)]")
			}
			if self.print.contains(.function) {
				log.append(" [function: \(function)]")
			}
			if self.print.contains(.line) {
				log.append(" [line: \(line)]")
			}
			if self.print.contains(.message) {
				log.append(" \(message)")
			}

			if log.count > 0 {
				#if DEBUG
					if environment.contains(.debug) {
						Swift.print(log as AnyObject)
					}
				#else
					if environment.contains(.release) {
						Swift.print(log as AnyObject)
					}
				#endif
			}
		}
	}

	private static func color(level: SherlogLevel) -> String {
		var color = "🟢 "
		switch level {
		case .info:
			color = "🟢 "
		case .warning:
			color = "🟡 "
		case .error:
			color = "🔴 "
		default:
			color = "❓ "
		}
		return color
	}
}
