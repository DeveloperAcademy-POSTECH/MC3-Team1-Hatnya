//
//  Date+Extension.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/24.
//

import Foundation

extension Date {
    var getDayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
    
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        return dateFormatter.string(from: self)
    }
}
