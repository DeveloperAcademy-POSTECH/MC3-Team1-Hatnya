//
//  StudyInfo.swift
//  Hatnya
//
//  Created by 김원희 on 2022/07/22.
//

import Foundation

struct StudyGroup {
    var members: [Member]
    var name: String
    let code: String
    var description: String
    let cycle: StudyCycle
    let createdAt: Date
    let uid: String
}

extension StudyGroup {
    static let sampleData: [StudyGroup] = [
        StudyGroup(members: [], name: "영어 회화 스터디", code: "A1B2C3", description: "자유 주제로 매주 스피킹하는 모임입니다",
                   cycle: StudyCycle(cycle: 1, weekDay: ["월", "화"]),
                   createdAt: Date(), uid: ""),
        StudyGroup(members: [], name: "UIKit 스터디", code: "123456", description: "3달 안에 UIKit 정복하자!",
                   cycle: StudyCycle(cycle: 1, weekDay: ["수"]),
                   createdAt: Date(), uid: "")
    ]
}
