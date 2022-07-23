//
//  EditTaskTableViewCell.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/23.
//

import UIKit

final class EditTaskTableViewCell: UITableViewCell {
    
    var textField = UITextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViewHierachy()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewHierachy()
    }
    
}

extension EditTaskTableViewCell: UITextFieldDelegate {
    
    func configureViewHierachy() {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        contentView.addSubview(textField)
        
        let margin: CGFloat = 13
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: margin),
            textField.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: margin),
            textField.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -margin),
            textField.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -margin)
        ])
    }
    
    func setText(with text: String) {
        textField.text = text
        
    }
    
}
