//
//  SelectCycleDaysView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/22.
//

import UIKit

class SelectCycleDaysView: UIView {
    let cyclePickerView = CyclePickerView()
    let dayButtonStackView = DayButtonStackView()
    
//    2차 스프린트 ToDo - 선택한 주기 실시간으로 업데이트해서 표시
//    let selectedCycleDaysLabel: UILabel = {
//        let label = UILabel()
//        label.text = "숙제가 매주 월요일 및 목요일에 반복됩니다."
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.textColor = .systemGray2
//        return label
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func render() {
        cyclePickerView.backgroundColor = .systemGray6
        cyclePickerView.layer.cornerRadius = 10
        addSubview(cyclePickerView)
        cyclePickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cyclePickerView.topAnchor.constraint(equalTo: self.topAnchor),
            cyclePickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cyclePickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        addSubview(dayButtonStackView)
        dayButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayButtonStackView.topAnchor.constraint(equalTo: cyclePickerView.bottomAnchor, constant: 20),
            dayButtonStackView.leadingAnchor.constraint(equalTo: cyclePickerView.leadingAnchor),
            dayButtonStackView.centerXAnchor.constraint(equalTo: cyclePickerView.centerXAnchor),
            dayButtonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
//    2차 스프린트 ToDo - 선택한 주기 실시간으로 업데이트해서 표시
//        addSubview(selectedCycleDaysLabel)
//        selectedCycleDaysLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            selectedCycleDaysLabel.topAnchor.constraint(equalTo: dayButtonStackView.bottomAnchor, constant: 20),
//            selectedCycleDaysLabel.leadingAnchor.constraint(equalTo: dayButtonStackView.leadingAnchor),
//            selectedCycleDaysLabel.centerXAnchor.constraint(equalTo: dayButtonStackView.centerXAnchor),
//            selectedCycleDaysLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//        ])
    }
    
}

//    2차 스프린트 ToDo - 선택한 주기 실시간으로 업데이트해서 표시

//extension SelectCycleDaysView: UIGestureRecognizerDelegate {
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        var completeSentence = ""
//        let selectedCycle = cyclePickerView.selectedCycleLabel.text ?? ""
//
//        var days: [String] = []
//
//        if dayButtonStackView.sundayButton.isSelected {
//            days.append("일")
//        }
//        if dayButtonStackView.mondayButton.isSelected {
//            days.append("월")
//        }
//        if dayButtonStackView.tuesdayButton.isSelected {
//            days.append("화")
//        }
//        if dayButtonStackView.wednesdayButton.isSelected {
//            days.append("수")
//        }
//        if dayButtonStackView.thursdayButton.isSelected {
//            days.append("목")
//        }
//        if dayButtonStackView.fridayButton.isSelected {
//            days.append("금")
//        }
//        if dayButtonStackView.saturdayButton.isSelected {
//            days.append("토")
//        }
//
//        completeSentence = "숙제가 " + selectedCycle + "마다 "
//        days.forEach { day in
//            completeSentence = completeSentence + day + ", "
//        }
//        completeSentence = completeSentence + "에 반복됩니다."
//        selectedCycleDaysLabel.text = completeSentence
//        return true
//    }
//
//}
