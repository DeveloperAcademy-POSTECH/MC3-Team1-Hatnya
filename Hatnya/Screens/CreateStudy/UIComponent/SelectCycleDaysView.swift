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
    
    func returnSelectedCycle() -> Int {
        switch cycleSegmentedControlView.selectedCycle {
            case "1주":
                return 1
            case "2주":
                return 2
            case "3주":
                return 3
            case "4주":
                return 4
            default:
                return 0
        }
    }
    
}
