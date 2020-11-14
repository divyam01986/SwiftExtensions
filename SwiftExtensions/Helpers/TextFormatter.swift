import Foundation
import UIKit

class TextFormatter {
    static func superscriptText(text: String,
                                font: UIFont,
                                color: UIColor,
                                superscriptRange: NSRange) -> NSAttributedString {
        let superscriptFont = font.withSize(0.7 * font.pointSize)
        let result = NSMutableAttributedString(string: text,
                                               attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        result.addAttributes([NSAttributedString.Key.font: superscriptFont, NSAttributedString.Key.baselineOffset: 8], range: superscriptRange)
        return result
    }
    
    
    static func subscriptText(text: String,
                              font: UIFont,
                              color: UIColor,
                              subscriptRange: NSRange) -> NSAttributedString {
        let subscriptFont = font.withSize(0.7 * font.pointSize)
        let result = NSMutableAttributedString(string: text,
                                               attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color])
        result.addAttributes([NSAttributedString.Key.font: subscriptFont, NSAttributedString.Key.baselineOffset: -8], range: subscriptRange)
        return result
    }
}
