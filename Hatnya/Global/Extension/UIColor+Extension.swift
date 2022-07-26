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
    
    // MARK: - chartColor
    
    static var chart001: UIColor {
        return UIColor(hex: "FDC3B1")
    }
    
    static var chart002: UIColor {
        return UIColor(hex: "FFE58A")
    }
    
    static var chart003: UIColor {
        return UIColor(hex: "C9E8EF")
    }
    
    static var chart004: UIColor {
        return UIColor(hex: "D3C9EF")
    }
    
    static let colorPalette: [UIColor] = [.chart001, .chart002, .chart003, .chart004, .chart001, .chart002, .chart003, .chart004]
}
