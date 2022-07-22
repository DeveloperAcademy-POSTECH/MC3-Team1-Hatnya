//
//  DayButtonStackView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/21.
//

import UIKit

class DayButtonStackView: UIStackView {
    let mondayButton = DayButtonView()
    let tuesdayButton = DayButtonView()
    let wednesdayButton = DayButtonView()
    let thursdayButton = DayButtonView()
    let fridayButton = DayButtonView()
    let saturdayButton = DayButtonView()
    let sundayButton = DayButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .equalSpacing
        self.spacing = 0
        
        render()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        sundayButton.setName(title: "일")
        mondayButton.setName(title: "월")
        tuesdayButton.setName(title: "화")
        wednesdayButton.setName(title: "수")
        thursdayButton.setName(title: "목")
        fridayButton.setName(title: "금")
        saturdayButton.setName(title: "토")
        
        [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton].forEach { btn in
            addArrangedSubview(btn)
        }
    }
    
}
