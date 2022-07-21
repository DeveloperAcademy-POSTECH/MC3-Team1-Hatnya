//
//  JoinStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class JoinStudyViewController: UIViewController {
    
    @IBOutlet private var codeTextField: UITextField!
    @IBOutlet private var searchResultView: UIView!
    @IBOutlet private var studyGroupName: UILabel!
    @IBOutlet private var studyGroupDescription: UILabel!
    @IBOutlet private var nextButton: UIButton!
    
    private func searchStudyGroup() {
        for studyGroup in StudyGroup.sampleData {
            if codeTextField.text == studyGroup.code {
                searchResultView.backgroundColor = .systemGray6
                studyGroupName.text = studyGroup.studyName
                studyGroupDescription.text = studyGroup.description
                return
            } else {
                studyGroupName.text = "해당하는 스터디가 없습니다."
            }
        }
    }
    
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
        searchResultView.layer.cornerRadius = 5
        nextButton.isEnabled = false
        nextButton.setBackgroundColor(.systemGray6, for: .disabled)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setTextField()
    }
    
}

extension UITextField {
    
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(1)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height + 10, width: viewSize - 40, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
    
}

extension JoinStudyViewController: UITextFieldDelegate {
    private func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if textField.text?.count ?? 0 == maxLength {
            searchStudyGroup()
            nextButton.isEnabled = true
        } else if textField.text?.count ?? 0 > maxLength {
            textField.deleteBackward()
        } else {
            nextButton.isEnabled = false
            studyGroupName.text = ""
            studyGroupDescription.text = ""
            searchResultView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
    private func setTextField() {
        codeTextField.clearButtonMode = .whileEditing
        codeTextField.underlined(viewSize: UIScreen.main.bounds.width, color: .systemGray)
    }
    
}
