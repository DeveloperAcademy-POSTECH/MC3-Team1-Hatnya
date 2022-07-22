//
//  StudyGroup.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import Foundation

struct StudyGroup {
    var members: [Member]
    let studyName: String
    let code: String
    let description: String
    let cycle: StudyCycle
    let createdAt: Date
}

extension StudyGroup {
    static let sampleData: [StudyGroup] = [
        StudyGroup(members: [], studyName: "영어 회화 스터디", code: "A1B2C3", description: "자유 주제로 매주 스피킹하는 모임입니다",
                   cycle: StudyCycle(cycle: 1, weekDay: ["월", "화"]),
                   createdAt: Date()),
        StudyGroup(members: [], studyName: "UIKit 스터디", code: "123456", description: "3달 안에 UIKit 정복하자!",
                   cycle: StudyCycle(cycle: 1, weekDay: ["수"]),
                   createdAt: Date())
    ]
}
