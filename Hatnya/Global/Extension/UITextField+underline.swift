//
//  UITextField+underline.swift
//  Hatnya
//
//  Created by kelly on 2022/07/22.
//

import UIKit

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 11, width: viewSize, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
