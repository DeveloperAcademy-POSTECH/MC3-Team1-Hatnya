//
//  CreateStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class CreateStudyViewController: UIViewController {
    private let studyNameLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 이름"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let studyNameTextField: UITextField = {
        let textField = UITextField()
        //textField.backgroundColor = UIColor.brown
        //textField.underlined(viewSize: CGFloat(100), color: UIColor.blue)
        textField.placeholder = "스터디 이름을 입력해주세요."
        textField.clearButtonMode = .always
        return textField
    }()
    
    private let studyInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 설명"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let studyInfoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "스터디 한 줄 소개를 입력해주세요."
        textField.clearButtonMode = .always
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
    }
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func render() {
        let safeArea = view.safeAreaLayoutGuide
//        studyNameTextField.delegate = self
//        studyInfoTextField.delegate = self
        
        view.addSubview(studyNameLabel)
        studyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studyNameLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 75),
            studyNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(studyNameTextField)
        studyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studyNameTextField.topAnchor.constraint(equalTo: studyNameLabel.bottomAnchor, constant: 20),
            studyNameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(studyInfoLabel)
        studyInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studyInfoLabel.topAnchor.constraint(equalTo: studyNameTextField.bottomAnchor, constant: 50),
            studyInfoLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(studyInfoTextField)
        studyInfoTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studyInfoTextField.topAnchor.constraint(equalTo: studyInfoLabel.bottomAnchor, constant: 20),
            studyInfoTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
    }
}

import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = CreateStudyViewController
    
    func makeUIViewController(context: Context) -> CreateStudyViewController {
        return CreateStudyViewController()
    }
    
    func updateUIViewController(_ uiViewController: CreateStudyViewController, context: Context) {
    }
    
}

@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
