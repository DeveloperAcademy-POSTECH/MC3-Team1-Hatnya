//
//  DayButtonStackView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/21.
//

import UIKit

class DayButtonStackView: UIStackView {
    private lazy var mondayButton = DayButtonView()
    private lazy var tuesdayButton = DayButtonView()
    private lazy var wednesdayButton = DayButtonView()
    private lazy var thursdayButton = DayButtonView()
    private lazy var fridayButton = DayButtonView()
    private lazy var saturdayButton = DayButtonView()
    private lazy var sundayButton = DayButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configUI() {
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .equalSpacing
        self.spacing = 0
        sundayButton.setName(title: "일")
        mondayButton.setName(title: "월")
        tuesdayButton.isSelected = true
        tuesdayButton.changeButtonColorToBlue()
        tuesdayButton.setName(title: "화")
        wednesdayButton.setName(title: "수")
        thursdayButton.setName(title: "목")
        fridayButton.setName(title: "금")
        saturdayButton.setName(title: "토")
        
        [sundayButton, mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton, saturdayButton].forEach { btn in
            addArrangedSubview(btn)
        }
    }
    
    func getSelectedDays() -> [String] {
        var selectedDays: [String] = []
        
        if mondayButton.isSelected {
            selectedDays.append("월")
        }
        if tuesdayButton.isSelected {
            selectedDays.append("화")
        }
        if wednesdayButton.isSelected {
            selectedDays.append("수")
        }
        if thursdayButton.isSelected {
            selectedDays.append("목")
        }
        if fridayButton.isSelected {
            selectedDays.append("금")
        }
        if saturdayButton.isSelected {
            selectedDays.append("토")
        }
        if sundayButton.isSelected {
            selectedDays.append("일")
        }
        
        return selectedDays
    }
}
