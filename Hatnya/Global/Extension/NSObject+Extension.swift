//
//  NSObject+Extension.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/26.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
