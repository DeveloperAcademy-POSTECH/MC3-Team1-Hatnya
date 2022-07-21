//
//  CreateStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class CreateStudyViewController: UIViewController {
    private let getStudyNameView = GetInfoView()
    private let getStudyDescriptView = GetInfoView()
    private let cyclePickerView = CyclePickerView()
    private let dayButtonStackView = DayButtonStackView()
    
    private let backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "xmark")
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let studyCycleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 주기"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        render()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getStudyNameView.valueTextField.underlined(viewSize: getStudyNameView.valueTextField.bounds.width, color: UIColor.gray)
        getStudyDescriptView.valueTextField.underlined(viewSize: getStudyDescriptView.valueTextField.bounds.width, color: UIColor.gray)
    }
    
    private func configUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func render() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeArea.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 44),
            backButton.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        getStudyNameView.update(title: "스터디 이름", placeHolder: "스터디 이름을 입력해주세요.")
        view.addSubview(getStudyNameView)
        getStudyNameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getStudyNameView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            getStudyNameView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            getStudyNameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        getStudyDescriptView.update(title: "스터디 설명", placeHolder: "스터디 한 줄 소개를 입력해주세요.")
        view.addSubview(getStudyDescriptView)
        getStudyDescriptView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getStudyDescriptView.topAnchor.constraint(equalTo: getStudyNameView.bottomAnchor, constant: 50),
            getStudyDescriptView.leadingAnchor.constraint(equalTo: getStudyNameView.leadingAnchor),
            getStudyDescriptView.centerXAnchor.constraint(equalTo: getStudyNameView.centerXAnchor)
        ])
        
        view.addSubview(studyCycleLabel)
        studyCycleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            studyCycleLabel.topAnchor.constraint(equalTo: getStudyDescriptView.bottomAnchor, constant: 50),
            studyCycleLabel.leadingAnchor.constraint(equalTo: getStudyDescriptView.leadingAnchor),
            studyCycleLabel.centerXAnchor.constraint(equalTo: getStudyDescriptView.centerXAnchor)
        ])
        
        cyclePickerView.backgroundColor = .systemGray6
        cyclePickerView.layer.cornerRadius = 10
        view.addSubview(cyclePickerView)
        cyclePickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cyclePickerView.topAnchor.constraint(equalTo: studyCycleLabel.bottomAnchor, constant: 20),
            cyclePickerView.leadingAnchor.constraint(equalTo: studyCycleLabel.leadingAnchor),
            cyclePickerView.centerXAnchor.constraint(equalTo: studyCycleLabel.centerXAnchor)
        ])
        
        view.addSubview(dayButtonStackView)
        dayButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dayButtonStackView.topAnchor.constraint(equalTo: cyclePickerView.bottomAnchor, constant: 20),
            dayButtonStackView.leadingAnchor.constraint(equalTo: cyclePickerView.leadingAnchor),
            dayButtonStackView.centerXAnchor.constraint(equalTo: cyclePickerView.centerXAnchor)
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
