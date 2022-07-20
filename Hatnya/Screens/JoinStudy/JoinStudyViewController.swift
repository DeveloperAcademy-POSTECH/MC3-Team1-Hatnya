//
//  JoinStudyViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import UIKit

class JoinStudyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet private var codeTextField: UITextField!
    @IBOutlet private var searchResultView: UIView!
    @IBOutlet private var studyGroupName: UILabel!
    @IBOutlet private var studyGroupDescription: UILabel!
    @IBOutlet private var nextButton: UIButton!
    
    func searchStudyGroup() {
        print("searching study group")
    }
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if(textField.text?.count ?? 0 == maxLength) {
            searchStudyGroup()
            nextButton.isEnabled = true
        } else if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        } else {
            nextButton.isEnabled = false
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
    
}
