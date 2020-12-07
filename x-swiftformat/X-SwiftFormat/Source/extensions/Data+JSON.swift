import Foundation

extension Data {

	var json: Any? {
		do {
			return try JSONSerialization.jsonObject(with: self, options: .mutableContainers)
		} catch _ {
		}
		return nil
	}
}
