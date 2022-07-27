//
//  String+Extension.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/24.
//

import Foundation

extension String {
    var stringToDate: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.date(from: self)
    }
}
