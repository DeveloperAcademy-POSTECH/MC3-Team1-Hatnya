//
//  DayButtonStackView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/21.
//

import UIKit

class DayButtonStackView: UIStackView {
    lazy var mondayBtn = DayButtonView()
    lazy var tuesdayBtn = DayButtonView()
    lazy var wednesdayBtn = DayButtonView()
    lazy var thursdayBtn = DayButtonView()
    lazy var fridayBtn = DayButtonView()
    lazy var saturdayBtn = DayButtonView()
    lazy var sundayBtn = DayButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        render()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configUI() {
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .equalSpacing
        self.spacing = 0
    }
    
    private func render() {
        sundayBtn.setName(title: "일")
        mondayBtn.setName(title: "월")
        tuesdayBtn.isSelected = true
        tuesdayBtn.toBlue()
        tuesdayBtn.setName(title: "화")
        wednesdayBtn.setName(title: "수")
        thursdayBtn.setName(title: "목")
        fridayBtn.setName(title: "금")
        saturdayBtn.setName(title: "토")
        
        [sundayBtn, mondayBtn, tuesdayBtn, wednesdayBtn, thursdayBtn, fridayBtn, saturdayBtn].forEach { btn in
            addArrangedSubview(btn)
        }
    }
    
}
