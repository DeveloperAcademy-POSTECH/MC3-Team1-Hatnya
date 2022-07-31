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
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "YYYY.MM.dd"
        return dataFormatter.string(from: self)
    }
}
