//
//  Member.swift
//  Hatnya
//
//  Created by Seungwon Choi on 2022/07/26.
//

import Foundation

struct Member: Codable {
    let nickname: String
    let homeworks: [Homework]
}
