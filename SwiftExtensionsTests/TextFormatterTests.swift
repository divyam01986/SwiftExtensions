import XCTest
import UIKit
@testable import SwiftExtensions

class TextFormatterTests: XCTestCase {
    func testSuperscriptFormatter() {
        let text = "HelloYou"
        let result = TextFormatter.superscriptText(text: text,
                                                   font: UIFont(name: "Helvetica Neue", size: 16.0)!,
                                                   color: UIColor.black,
                                                   superscriptRange: NSRange(location: text.count - 3, length: 3))
        do {
            let attributes = try XCTUnwrap(result.attributes(at: text.count - 3, effectiveRange: nil))
            XCTAssertEqual(3, attributes[NSAttributedString.Key.baselineOffset] as? Int)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testSubscriptFormatter() {
        let text = "HelloYou"
        let result = TextFormatter.subscriptText(text: text,
                                                 font: UIFont(name: "Helvetica Neue", size: 16.0)!,
                                                 color: UIColor.black,
                                                 subscriptRange: NSRange(location: text.count - 3, length: 3))
        do {
            let attributes = try XCTUnwrap(result.attributes(at: text.count - 3, effectiveRange: nil))
            XCTAssertEqual(-3, attributes[NSAttributedString.Key.baselineOffset] as? Int)
        } catch {
            XCTFail("\(error)")
        }
    }
}
