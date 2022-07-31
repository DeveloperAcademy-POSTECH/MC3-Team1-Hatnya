//
//  Homework.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import Foundation

struct Homework: Hashable, Codable {
    var name: String
    var isCompleted: Bool
}

extension Homework {
    static let mock = Homework(name: "", isCompleted: false)
}

struct Homeworks: Codable {
    let cycle: Int
    var list: [Homework]
}

extension Homeworks {
    static let mock = Homeworks(cycle: 1, list: [Homework.mock])
}
