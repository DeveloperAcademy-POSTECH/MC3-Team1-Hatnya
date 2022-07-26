//
//  UIColor+Extension.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

extension UIColor {
        
    // MARK: - grey

    static var grey001: UIColor {
        return UIColor(hex: "#979797")
    }
    
    // MARK: - tagColor
    
    static var tagPink: UIColor {
        return UIColor(hex: "#FDC3B1")
    }
    static var tagYellow: UIColor {
        return UIColor(hex: "#FFE897")
    }
    static var tagGreen: UIColor {
        return UIColor(hex: "#D4EBCC")
    }
    static var tagLightBlue: UIColor {
        return UIColor(hex: "#C9E8EF")
    }
    static var tagPurple: UIColor {
        return UIColor(hex: "#D3C9EF")
    }

    static let colorPalette: [UIColor] = [.tagPink, .tagYellow, .tagGreen, .tagLightBlue, .tagPurple, .tagPink, .tagYellow, .tagGreen]
}
