import Cocoa

extension String {

	func heightWithConstrainedWidth(width: CGFloat, font: NSFont) -> CGFloat {
		let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		return boundingBox.height
	}

	func widthWithConstrainedHeight(height: CGFloat, font: NSFont) -> CGFloat {
		let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		return boundingBox.width
	}
}
