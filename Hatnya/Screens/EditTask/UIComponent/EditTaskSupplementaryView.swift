//
//  EditTaskSupplementaryView.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/23.
//

import SwiftUI
import UIKit

final class EditTaskSupplementaryView: UITableViewHeaderFooterView {
    
    private lazy var plusButton: UIButton = {
        var config = UIImage.SymbolConfiguration(paletteColors: [.systemGreen])
        config = config.applying(UIImage.SymbolConfiguration(scale: .large))
        let plusImage = UIImage(systemName: "plus.circle.fill", withConfiguration: config)
        $0.setImage(plusImage, for: .normal)
        $0.addTarget(self, action: #selector(plusButtonTouched), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private var textField = UITextField()
    
    private lazy var borderView: UIView = {
        $0.backgroundColor = .secondarySystemFill
        return $0
    }(UIView())
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHierachy()
        configureUI()
    }
    
}

extension EditTaskSupplementaryView {
    
    private func configureHierachy() {
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30)
        ])
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
        
        borderView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(borderView)
        NSLayoutConstraint.activate([
            borderView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5),
            borderView.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: 5),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
    }
    
    private func configureUI() {
        textField.placeholder = "새로운 항목 추가"
    }
    
    @objc
    func plusButtonTouched() {
        print(textField.text!)
        textField.text = ""
    }
    
}

struct EditTaskSupplementaryPreview: PreviewProvider {
    
    static var previews: some View {
        EditTaskSupplementaryView().toPreview()
    }
    
}
