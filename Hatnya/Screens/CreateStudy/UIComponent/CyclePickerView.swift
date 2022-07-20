//
//  CyclePickerView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/20.
//

import UIKit

class CyclePickerView: UIView {
    let cycles = ["1", "2", "3", "4"]
    
    private let selectedCycleLabel: UILabel = {
        let label = UILabel()
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor.lightGray.cgColor
        border.borderWidth = width
        label.layer.addSublayer(border)
        label.text = "1주"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = UIColor.lightGray
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func render() {
        pickerView.delegate = self
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: self.topAnchor),
            pickerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pickerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 130),
            pickerView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

}
