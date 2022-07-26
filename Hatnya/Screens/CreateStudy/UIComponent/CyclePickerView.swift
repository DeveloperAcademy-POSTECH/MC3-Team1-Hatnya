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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "반복"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var selectedCycleLabel: UILabel = {
        let label = UILabel()
        label.text = "1주"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUI()
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configUI() {
        pickerView.delegate = self
        pickerView.isHidden = true
    }
    
    private func render() {
        addSubview(vStackView)
        
        [titleLabel, selectedCycleLabel].forEach { subview in
            hStackView.addArrangedSubview(subview)
        }

        [hStackView, pickerView].forEach { subview in
            vStackView.addArrangedSubview(subview)
        }
        
        let tapGesture: UITapGestureRecognizer
        tapGesture = UITapGestureRecognizer()
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
            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            hStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

extension CyclePickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return cycles[row]
        } else {
            return "주"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print("row: \(row)")
            print("value: \(cycles[row])")
            selectedCycleLabel.text = cycles[row] + "주"
        }
    }
}

extension CyclePickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return cycles.count
        } else {
            return 1
        }
    }
}

extension CyclePickerView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if isShown == true {
            pickerView.isHidden = true
        } else {
            pickerView.isHidden = false
        }
        isShown.toggle()
        return true
    }
}
