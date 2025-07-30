import Foundation

extension Array {

	subscript(safe index: Int) -> Element? {
		return index >= 0 && index < count ? self[index] : nil
	}
}
