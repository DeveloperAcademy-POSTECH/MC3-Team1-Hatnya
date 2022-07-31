//
//  Member.swift
//  Hatnya
//
//  Created by Seungwon Choi on 2022/07/26.
//

import Foundation

struct Member: Codable {
    let uid: String
    let nickname: String
    let homeworks: [Homework]
}

extension Member {
    static let testMemberList: [Member] = [
        Member(uid: "", nickname: "Chemi", homeworks: [
            Homework(name: "알고리즘 1000번 문제", isCompleted: false),
            Homework(name: "알고리즘 2000번 문제", isCompleted: true),
            Homework(name: "알고리즘 3000번 문제", isCompleted: false),
            Homework(name: "알고리즘 4000번 문제", isCompleted: true)
        ]),
        Member(uid: "", nickname: "Zero", homeworks: [
            Homework(name: "알고리즘 1000번 문제", isCompleted: false),
            Homework(name: "알고리즘 2000번 문제", isCompleted: true),
            Homework(name: "알고리즘 3000번 문제", isCompleted: true),
            Homework(name: "알고리즘 4000번 문제", isCompleted: false)
        ]),
        Member(uid: "", nickname: "Lia", homeworks: [
            Homework(name: "알고리즘 1000번 문제", isCompleted: true),
            Homework(name: "알고리즘 2000번 문제", isCompleted: false),
            Homework(name: "알고리즘 3000번 문제", isCompleted: false),
            Homework(name: "알고리즘 4000번 문제", isCompleted: true)
        ]),
        Member(uid: "", nickname: "May", homeworks: [
            Homework(name: "알고리즘 1000번 문제", isCompleted: true),
            Homework(name: "알고리즘 2000번 문제", isCompleted: true),
            Homework(name: "알고리즘 3000번 문제", isCompleted: false),
            Homework(name: "알고리즘 4000번 문제", isCompleted: false)
        ]),
        Member(uid: "", nickname: "Eve", homeworks: [
            Homework(name: "알고리즘 1000번 문제", isCompleted: false),
            Homework(name: "알고리즘 2000번 문제", isCompleted: false),
            Homework(name: "알고리즘 3000번 문제", isCompleted: true),
            Homework(name: "알고리즘 4000번 문제", isCompleted: false)
        ]),
        Member(uid: "", nickname: "Bit", homeworks: [
            Homework(name: "알고리즘 1000번 문제", isCompleted: true),
            Homework(name: "알고리즘 2000번 문제", isCompleted: true),
            Homework(name: "알고리즘 3000번 문제", isCompleted: true),
            Homework(name: "알고리즘 4000번 문제", isCompleted: true)
        ])
    ]
}
