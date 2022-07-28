//
//  EditTaskSupplementaryView.swift
//  Hatnya
//
//  Created by 리아 on 2022/07/23.
//

import Combine
import SwiftUI
import UIKit

final class EditTaskSupplementaryView: UITableViewHeaderFooterView {
    
    @Published var newTask = Homework.mock
    
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
        [plusButton, textField, borderView].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(component)
        }

        NSLayoutConstraint.activate([
            plusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 30),

            textField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textField.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textField.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),

            borderView.centerYAnchor.constraint(equalTo: contentView.bottomAnchor),
            borderView.heightAnchor.constraint(equalToConstant: 0.5),
            borderView.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: 5),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 48)
        ])
    }
    
    private func configureUI() {
        textField.placeholder = "새로운 항목 추가"
    }
    
    @objc
    func plusButtonTouched() {
        guard let text = textField.text else { return }
        newTask = Homework(name: text, count: 1, isCompleted: false)
        textField.text = ""
    }
    
}

struct EditTaskSupplementaryPreview: PreviewProvider {
    
    static var previews: some View {
        EditTaskSupplementaryView().toPreview()
    }
    
}
