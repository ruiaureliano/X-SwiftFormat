//
//  PreviewEditorSyntax.swift
//  X-SwiftFormat
//
//  Created by Rui Aureliano on 31/03/2020.
//  Copyright © 2020 Rui Aureliano. All rights reserved.
//

import Cocoa

enum PreviewEditorSyntaxType: String {
	case plain
	case number
	case string
	case identifier
	case keyword
	case comment
}

private let kPlainTextColor: NSColor? = NSColor(named: "preview-text-color")
private let kNumberTextColor: NSColor? = NSColor(named: "preview-number-color")
private let kStringTextColor: NSColor? = NSColor(named: "preview-string-color")
private let kIdentifierTextColor: NSColor? = NSColor(named: "preview-identifier-color")
private let kKeywordTextColor: NSColor? = NSColor(named: "preview-keyword-color")
private let kCommentTextColor: NSColor? = NSColor(named: "preview-comment-color")

class PreviewEditorSyntax: NSObject {

	private let keywords = [
		"as", "associatedtype", "break", "case", "catch", "class", "continue", "convenience", "default", "defer", "deinit", "else", "enum", "extension", "fallthrough",
		"false", "fileprivate", "final", "for", "func", "get", "guard", "if", "import", "in", "init", "inout", "internal", "is", "lazy", "let", "mutating", "nil",
		"nonmutating", "open", "operator", "override", "private", "protocol", "public", "repeat", "required", "rethrows", "return", "required", "self",
		"set", "static", "struct", "subscript", "super", "switch", "throw", "throws", "true", "try", "typealias", "unowned", "var", "weak", "where", "while",
	]

	private let stdlibIdentifiers = [
		"Any", "Array", "AutoreleasingUnsafePointer", "BidirectionalReverseView", "Bit", "Bool", "CFunctionPointer", "COpaquePointer", "CVaListPointer",
		"Character", "CollectionOfOne", "ConstUnsafePointer", "ContiguousArray", "Data", "Dictionary", "DictionaryGenerator", "DictionaryIndex",
		"Double", "EmptyCollection", "EmptyGenerator", "EnumerateGenerator", "FilterCollectionView", "FilterCollectionViewIndex", "FilterGenerator",
		"FilterSequenceView", "Float", "Float80", "FloatingPointClassification", "GeneratorOf", "GeneratorOfOne", "GeneratorSequence", "HeapBuffer",
		"HeapBuffer", "HeapBufferStorage", "HeapBufferStorageBase", "ImplicitlyUnwrappedOptional", "IndexingGenerator", "Int", "Int16", "Int32",
		"Int64", "Int8", "IntEncoder", "LazyBidirectionalCollection", "LazyForwardCollection", "LazyRandomAccessCollection", "LazySequence",
		"Less", "MapCollectionView", "MapSequenceGenerator", "MapSequenceView", "MirrorDisposition", "ObjectIdentifier", "OnHeap", "Optional",
		"PermutationGenerator", "QuickLookObject", "RandomAccessReverseView", "Range", "RangeGenerator", "RawByte", "Repeat", "ReverseBidirectionalIndex",
		"Printable", "ReverseRandomAccessIndex", "SequenceOf", "SinkOf", "Slice", "StaticString", "StrideThrough", "StrideThroughGenerator", "StrideTo",
		"StrideToGenerator", "String", "Index", "UTF8View", "Index", "UnicodeScalarView", "IndexType", "GeneratorType", "UTF16View", "UInt", "UInt16", "UInt32",
		"UInt64", "UInt8", "UTF16", "UTF32", "UTF8", "UnicodeDecodingResult", "UnicodeScalar", "Unmanaged", "UnsafeArray", "UnsafeArrayGenerator",
		"UnsafeMutableArray", "UnsafePointer", "VaListBuilder", "Header", "Zip2", "ZipGenerator2",
	]

	func hightlightSource(text: String, in textView: NSTextView) {

		/* Reset all */
		textView.setTextColor(kPlainTextColor, range: NSRange(location: 0, length: text.count))

		/* Hightlight UIKit & AppKit */
		apply(pattern: "\\b(NS|UI)[A-Z][a-zA-Z]+\\b", in: text, color: kIdentifierTextColor, textView: textView)

		/* Hightlight Functions */
		apply(pattern: "\\b(println|print)(?=\\()", in: text, color: kIdentifierTextColor, textView: textView)
		apply(pattern: "\\.[A-Za-z_]+\\w*", in: text, color: kIdentifierTextColor, textView: textView)

		/* Hightlight Keywords */
		apply(pattern: "\\b(\(keywords.joined(separator: "|")))+\\b", in: text, color: kKeywordTextColor, textView: textView)

		/* Hightlight stdlibIdentifiers */
		apply(pattern: "\\b(\(stdlibIdentifiers.joined(separator: "|")))+\\b", in: text, color: kIdentifierTextColor, textView: textView)

		/* Hightlight Numbers */
		apply(pattern: "\\b([0-9]+(\\.[0-9]+)?)\\b", in: text, color: kNumberTextColor, textView: textView)

		/* Hightlight String Single-Line */
		apply(pattern: "(\"|@\")[^\"\\n]*(@\"|\")", in: text, color: kStringTextColor, textView: textView)

		/* Hightlight String Multi-Line */
		apply(pattern: "(\"\"\")(.*?)(\"\"\")", in: text, options: [.dotMatchesLineSeparators], color: kStringTextColor, textView: textView)

		/* Hightlight Line Comment */
		apply(pattern: "//(.*)", in: text, color: kCommentTextColor, textView: textView)

		/* Hightlight Multi-Line Comment */
		apply(pattern: "(/\\*)(.*)(\\*/)", in: text, options: [.dotMatchesLineSeparators], color: kCommentTextColor, textView: textView)
	}

	private func apply(pattern: String, in text: String, options: NSRegularExpression.Options = [], color: NSColor?, textView: NSTextView) {
		if let regex = try? NSRegularExpression(pattern: pattern, options: options) {
			let matches = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
			for match in matches {
				textView.setTextColor(color, range: match.range)
			}
		}
	}
}
