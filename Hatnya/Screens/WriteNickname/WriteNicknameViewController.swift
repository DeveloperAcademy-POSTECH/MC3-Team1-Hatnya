//
//  WriteNicknameViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

final class WriteNicknameViewController: UIViewController {

    private lazy var backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디에서 사용할 닉네임을 입력하세요"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        return label
    }()
    
    private lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "ex. 아기장수우투리"
        return textField
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "x.circle.fill")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("그룹 입장하기", for: .normal)
        button.isSelected = false
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonTapHandler), for: .touchUpInside)
        return button
    }()
    
    @objc
    func nextButtonTapHandler(sender: UIButton) {
        print("button click")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureAddSubviews()
        configureConstraints()
        configureTextField()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setTextField()
    }
    
}

extension WriteNicknameViewController {
    
    private func configureView() {
        guard let view = self.view else { return }
        
        view.backgroundColor = .systemBackground
    }
    
    private func configureAddSubviews() {
        guard let view = self.view else { return }
        
        [backButton, titleLabel, inputTextField, deleteButton, nextButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func configureConstraints() {
        guard let view = self.view else { return }
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 43),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            inputTextField.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension WriteNicknameViewController: UITextFieldDelegate {
    
    private func configureTextField() {
        inputTextField.delegate = self
    }
    
    private func setTextField() {
        inputTextField.clearButtonMode = .whileEditing
        inputTextField.underlined(viewSize: UIScreen.main.bounds.width, color: .systemGray)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == nil || textField.text == "" {
            nextButton.backgroundColor = .lightGray
            nextButton.isUserInteractionEnabled = false
        } else {
            nextButton.backgroundColor = .blue
            nextButton.isUserInteractionEnabled = true
        }
    }
    
}
