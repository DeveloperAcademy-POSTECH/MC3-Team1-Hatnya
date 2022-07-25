//
//  UILabel+StrikeThrough.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/21.
//

import UIKit

extension UILabel {
    
    func strikeThrough(_ isStrikeThrough: Bool) {
        if isStrikeThrough {
            if let text = self.text {
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(
                    .strikethroughStyle,
                    value: NSUnderlineStyle.single.rawValue,
                    range: NSRange(location: 0, length: attributedText.length))
                self.attributedText = attributedText
            }
        } else {
            if let attributedText = self.attributedText {
                let text = attributedText.string
                self.attributedText = nil
                self.text = text
            }
        }
    }
    
}
