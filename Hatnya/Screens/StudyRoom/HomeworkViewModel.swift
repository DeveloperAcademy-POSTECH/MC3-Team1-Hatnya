//
//  HomeworkViewModel.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/28.
//

import Foundation

final class HomeworkViewModel {
    
    @Published private(set) var homeworks: Homeworks
    
    init() {
        homeworks = Homeworks.mock
    }
    
    func update(with homeworks: Homeworks) {
        self.homeworks = homeworks
    }
    
    func update(with homework: [Homework]) {
        homeworks.list = homework
    }
    
}
