//
//  Homework.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/20.
//

import Foundation

struct Homework: Hashable {
    let id = UUID()
    let name: String
    let due: Date
    let isCompleted: Bool
}

struct HomeworkMockData {
    static let list = [hw1, hw2, hw3]
    static let hw1 = Homework(name: "알고리즘 1091번", due: Date(), isCompleted: true)
    static let hw2 = Homework(name: "알고리즘 3434번", due: Date(), isCompleted: false)
    static let hw3 = Homework(name: "DP 개념 공부", due: Date(), isCompleted: false)
}
