//
//  TagColor.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/21.
//

import UIKit

enum TagColor: Int, CaseIterable {
    case pink
    case yellow
    case green
    case lightBlue
    case purple
    
    static func color(_ tagColor: TagColor) -> UIColor {
        switch tagColor {
        case .pink:
            return .tagPink
        case .yellow:
            return .tagYellow
        case .green:
            return .tagGreen
        case .lightBlue:
            return .tagLightBlue
        case .purple:
            return .tagPurple
        }
    }
    
    static func order(index: Int) -> UIColor {
        let colorNum = index % Self.allCases.count
        let orderColor = TagColor(rawValue: colorNum) ?? .pink
        return Self.color(orderColor)
    }

}
