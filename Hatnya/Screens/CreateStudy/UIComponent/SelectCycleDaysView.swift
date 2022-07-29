//
//  SelectCycleDaysView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/22.
//

import UIKit

final class SelectCycleDaysView: UIView {
    private lazy var cycleSegmentedControlView = CycleSegmentedControlView()
    private lazy var dayButtonStackView = DayButtonStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func render() {
        [cycleSegmentedControlView, dayButtonStackView].forEach { view in
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            cycleSegmentedControlView.topAnchor.constraint(equalTo: self.topAnchor),
            cycleSegmentedControlView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cycleSegmentedControlView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dayButtonStackView.topAnchor.constraint(equalTo: cycleSegmentedControlView.bottomAnchor, constant: 20),
            dayButtonStackView.leadingAnchor.constraint(equalTo: cycleSegmentedControlView.leadingAnchor),
            dayButtonStackView.centerXAnchor.constraint(equalTo: cycleSegmentedControlView.centerXAnchor),
            dayButtonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func getSelectedCycle() -> Int {
        switch cycleSegmentedControlView.selectedCycle {
        case .one:
            return 1
        case .two:
            return 2
        case .three:
            return 3
        case .four:
            return 4
        }
    }
    
    func getSelectedDays() -> [String] {
        var selectedDays: [String] = []
        
        if dayButtonStackView.sundayBtn.isSelected {
            selectedDays.append("일")
        }
        if dayButtonStackView.mondayBtn.isSelected {
            selectedDays.append("월")
        }
        if dayButtonStackView.tuesdayBtn.isSelected {
            selectedDays.append("화")
        }
        if dayButtonStackView.wednesdayBtn.isSelected {
            selectedDays.append("수")
        }
        if dayButtonStackView.thursdayBtn.isSelected {
            selectedDays.append("목")
        }
        if dayButtonStackView.fridayBtn.isSelected {
            selectedDays.append("금")
        }
        if dayButtonStackView.saturdayBtn.isSelected {
            selectedDays.append("토")
        }
        
        return selectedDays
    }
    
}
