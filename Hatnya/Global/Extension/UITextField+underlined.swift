//
//  UITextField+underlined.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/25.
//

import UIKit

extension UITextField {
    
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let borderWidth = CGFloat(1)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 40, height: borderWidth)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
    }
    
}
