//
//  CycleSegmentedControlView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/26.
//

import UIKit

final class CycleSegmentedControlView: UIView {
    enum Cycle: String, CaseIterable {
        case one = "1주"
        case two = "2주"
        case three = "3주"
        case four = "4주"
    }
    
    private(set) var selectedCycle = Cycle.one
    
    private lazy var cycleSegControl: UISegmentedControl = {
        let segcontrol = UISegmentedControl(items: Cycle.allCases.map {
            $0.rawValue
        })
        segcontrol.selectedSegmentIndex = 0
        segcontrol.backgroundColor = .systemGray6
        segcontrol.tintColor = .white
        segcontrol.addTarget(self, action: #selector(segControlChanged(segcontrol:)), for: UIControl.Event.valueChanged)
        return segcontrol
        
    }()
    
    private lazy var everyLabel: UILabel = {
        let label = UILabel()
        label.text = "마다"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func render() {
        [cycleSegControl, everyLabel].forEach { view in
            hStackView.addArrangedSubview(view)
        }
        
        addSubview(hStackView)
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: self.topAnchor),
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            hStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    @objc
    func segControlChanged(segcontrol: UISegmentedControl) {
        selectedCycle = Cycle.allCases[segcontrol.selectedSegmentIndex]
    }
}
