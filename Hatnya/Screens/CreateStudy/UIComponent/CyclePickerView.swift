//
//  CyclePickerView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/20.
//

import UIKit

class CyclePickerView: UIView {
    var isShown = false
    let cycles = ["1", "2", "3", "4"]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "반복"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    var selectedCycleLabel: UILabel = {
        let label = UILabel()
        label.text = "1주"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemBlue
        return label
    }()
    
    let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        return stackView
    }()
    
    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        addSubview(vStackView)
        
        [titleLabel, selectedCycleLabel].forEach { subview in
            hStackView.addArrangedSubview(subview)
        }

        [hStackView, pickerView].forEach { subview in
            vStackView.addArrangedSubview(subview)
        }
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        tapGesture.delegate = self
        hStackView.addGestureRecognizer(tapGesture)
        
        vStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedCycleLabel.translatesAutoresizingMaskIntoConstraints = false
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            vStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            vStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            vStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pickerView.heightAnchor.constraint(equalToConstant: 130),
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            hStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        pickerView.delegate = self
        pickerView.isHidden = true
    }

}
