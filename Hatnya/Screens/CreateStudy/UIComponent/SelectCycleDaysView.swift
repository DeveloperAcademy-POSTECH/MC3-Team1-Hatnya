//
//  SelectCycleDaysView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/22.
//

import UIKit

class SelectCycleDaysView: UIView {
    lazy var cyclePickerView = CyclePickerView()
    lazy var dayButtonStackView = DayButtonStackView()
    
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
    }
    
}
