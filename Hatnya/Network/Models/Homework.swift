//
//  Homework.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import Foundation

struct Homework: Codable, Hashable {
    var id: String
    var name: String
    var isCompleted: Bool
}

extension Homework {
    static let mock = Homework(id: "\(UUID())", name: "", isCompleted: false)
}

struct Homeworks: Codable {
    let count: Int
    var list: [Homework]
}

extension Homeworks {
    static let mock = Homeworks(count: 1, list: [Homework.mock])
}
