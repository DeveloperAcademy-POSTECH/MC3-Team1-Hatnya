//
//  Homework.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import Foundation

struct Homework: Hashable, Codable {
    let id = UUID()
    let name: String
    let count: Int
    let isCompleted: Bool
}

extension Homework {
    static let mock = Homework(name: "", count: 1, isCompleted: false)
}
