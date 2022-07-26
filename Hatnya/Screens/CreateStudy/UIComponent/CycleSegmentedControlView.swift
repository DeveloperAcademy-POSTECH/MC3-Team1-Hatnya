//
//  CycleSegmentedControlView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/26.
//

import UIKit

class CycleSegmentedControlView: UIView {
    var selectedCycle = "1주"
    let array = ["1주", "2주", "3주", "4주"]
    
    lazy var cycleSegControl: UISegmentedControl = {
        let segcontrol = UISegmentedControl(items: array)
        segcontrol.backgroundColor = .systemGray6
        segcontrol.tintColor = .white
        segcontrol.addTarget(self, action: #selector(segconChanged(segcon:)), for: UIControl.Event.valueChanged)
        return segcontrol
        
    }()
    
    private lazy var evryLabel: UILabel = {
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
        [cycleSegControl, evryLabel].forEach { view in
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
    func segconChanged(segcon: UISegmentedControl) {
        selectedCycle = array[segcon.selectedSegmentIndex]
        print(selectedCycle)
    }
}
