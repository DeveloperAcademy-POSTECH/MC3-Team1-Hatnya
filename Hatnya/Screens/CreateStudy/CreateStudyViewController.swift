//
//  CreateStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import SwiftUI
import UIKit

final class CreateStudyViewController: UIViewController {
//    2차 스프린트 ToDo - 선택한 주기 실시간으로 업데이트해서 표시
//    var selectedDays: [String] = [""]
    
    private lazy var getStudyNameView = GetInfoView()
    private lazy var getStudyDescriptView = GetInfoView()
    private lazy var selectCycleDayView = SelectCycleDaysView()
    
    private lazy var studyCycleLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 주기"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonTouch), for: .touchUpInside)
        return button
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
        
        [getStudyNameView, getStudyDescriptView, studyCycleLabel, selectCycleDayView, nextButton].forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        getStudyNameView.update(title: "스터디 이름", placeHolder: "스터디 이름을 입력해주세요.")
        NSLayoutConstraint.activate([
            getStudyNameView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30),
            getStudyNameView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            getStudyNameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        getStudyDescriptView.update(title: "스터디 설명", placeHolder: "스터디 한 줄 소개를 입력해주세요.")
        NSLayoutConstraint.activate([
            getStudyDescriptView.topAnchor.constraint(equalTo: getStudyNameView.bottomAnchor, constant: 50),
            getStudyDescriptView.leadingAnchor.constraint(equalTo: getStudyNameView.leadingAnchor),
            getStudyDescriptView.centerXAnchor.constraint(equalTo: getStudyNameView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            studyCycleLabel.topAnchor.constraint(equalTo: getStudyDescriptView.bottomAnchor, constant: 50),
            studyCycleLabel.leadingAnchor.constraint(equalTo: getStudyDescriptView.leadingAnchor),
            studyCycleLabel.centerXAnchor.constraint(equalTo: getStudyDescriptView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectCycleDayView.topAnchor.constraint(equalTo: studyCycleLabel.bottomAnchor, constant: 20),
            selectCycleDayView.leadingAnchor.constraint(equalTo: studyCycleLabel.leadingAnchor),
            selectCycleDayView.centerXAnchor.constraint(equalTo: studyCycleLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc
    private func nextButtonTouch() {
        let nicknameViewController = WriteNicknameViewController()
        self.navigationController?.pushViewController(nicknameViewController, animated: true)
    }
}

struct CreateStudyViewControllerPreview: PreviewProvider {

    static var previews: some View {
        CreateStudyViewController().toPreview()
    }

}
