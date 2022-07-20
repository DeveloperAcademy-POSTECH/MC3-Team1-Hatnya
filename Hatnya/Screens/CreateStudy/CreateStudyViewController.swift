//
//  CreateStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 11, width: viewSize, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}

class CreateStudyViewController: UIViewController {
    private let getStudyNameView = GetInfoView()
    private let getStudyDescriptView = GetInfoView()
    
    private let studyCycleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 주기"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private let selectedCycleLabel: UILabel = {
        let label = UILabel()
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: 10, width: 500, height: 40)
        border.borderWidth = width
        label.layer.addSublayer(border)
        label.text = "1주"
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
        view.backgroundColor = .white
    }
    
    private func render() {
        let safeArea = view.safeAreaLayoutGuide
        
        getStudyNameView.update(title: "스터디 이름", placeHolder: "스터디 이름을 입력해주세요.")
        view.addSubview(getStudyNameView)
        getStudyNameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            getStudyNameView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
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
            studyCycleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(selectedCycleLabel)
        selectedCycleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedCycleLabel.topAnchor.constraint(equalTo: studyCycleLabel.bottomAnchor, constant: 50),
            selectedCycleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
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
