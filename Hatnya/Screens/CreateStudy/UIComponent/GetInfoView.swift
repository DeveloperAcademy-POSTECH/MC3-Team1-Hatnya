//
//  GetInfoView.swift
//  Hatnya
//
//  Created by kelly on 2022/07/19.
//

import UIKit

class GetInfoView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let valueTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        render()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func render() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        addSubview(valueTextField)
        valueTextField.delegate = self
        valueTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            valueTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 10),
            valueTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            valueTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        valueTextField.underlined(viewSize: self.bounds.width, color: UIColor.red)
    }
    
    func update(title: String, placeHolder: String) {
        self.titleLabel.text = title
        self.valueTextField.placeholder = placeHolder
    }
}

extension GetInfoView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlined(viewSize: self.valueTextField.bounds.width, color: UIColor.blue)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: self.valueTextField.bounds.width, color: UIColor.gray)
    }
}
