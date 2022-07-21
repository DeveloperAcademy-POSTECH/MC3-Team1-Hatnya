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
    
    let selectedCycleDaysLabel: UILabel = {
        let label = UILabel()
        label.text = "숙제가 매주 월요일 및 목요일에 반복됩니다."
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            dayButtonStackView.centerXAnchor.constraint(equalTo: cyclePickerView.centerXAnchor)
        ])
        
        addSubview(selectedCycleDaysLabel)
        selectedCycleDaysLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedCycleDaysLabel.topAnchor.constraint(equalTo: dayButtonStackView.bottomAnchor, constant: 20),
            selectedCycleDaysLabel.leadingAnchor.constraint(equalTo: dayButtonStackView.leadingAnchor),
            selectedCycleDaysLabel.centerXAnchor.constraint(equalTo: dayButtonStackView.centerXAnchor),
            selectedCycleDaysLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
}
