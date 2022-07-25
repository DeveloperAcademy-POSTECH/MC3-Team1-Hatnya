//
//  JoinStudyViewController.swift
//  Hatnya
//
//  Created by Eve on 2022/07/19.
//

import UIKit

class JoinStudyViewController: UIViewController {
    
    @IBOutlet private var codeTextField: UITextField!
    @IBOutlet private var searchResultView: UIView!
    @IBOutlet private var studyGroupName: UILabel!
    @IBOutlet private var studyGroupDescription: UILabel!
    @IBOutlet private var nextButton: UIButton!
    
    @IBAction private func touchUpNextButton(_ sender: UIButton) {
        
    }
    
    @IBAction private func touchUpDismissButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func textDidChanged(_ sender: UITextField) {
        checkMaxLength(textField: codeTextField, maxLength: 6)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        codeTextField.delegate = self
        initSearchResultView()
        initNextButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setTextField()
    }
}

extension JoinStudyViewController: UITextFieldDelegate {
    private func initSearchResultView() {
        searchResultView.layer.cornerRadius = 5
    }
    
    private func initNextButton() {
        nextButton.isEnabled = false
        nextButton.setBackgroundColor(.systemGray6, for: .disabled)
    }
    
    private func searchStudyGroup() {
// TODO: 추후 Firebase 데이터 연동 후 sampleData 변수에 Firebase의 StudyGroup 데이터 넣으면 됨
//        for studyGroup in StudyGroup.sampleData {
//            if codeTextField.text == studyGroup.code {
//                searchResultView.backgroundColor = .systemGray6
//                studyGroupName.text = studyGroup.studyName
//                studyGroupDescription.text = studyGroup.description
//                return
//            } else {
//                studyGroupName.text = "해당하는 스터디가 없습니다."
//            }
//        }
    }
    
    private func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if let textLength = textField.text?.count {
            if textLength == maxLength {
                searchStudyGroup()
                nextButton.isEnabled = true
            } else if textField.text?.count ?? 0 > maxLength {
                textField.deleteBackward()
            } else {
                nextButton.isEnabled = false
                studyGroupName.text = ""
                studyGroupDescription.text = ""
                searchResultView.backgroundColor = .clear
            }
        }
    }
    
    private func setTextField() {
        codeTextField.clearButtonMode = .whileEditing
        // TODO: textField의 underlined 기능 extension 머지 후 주석 해제
        // codeTextField.underlined(viewSize: UIScreen.main.bounds.width, color: .systemGray)
    }
    
}
