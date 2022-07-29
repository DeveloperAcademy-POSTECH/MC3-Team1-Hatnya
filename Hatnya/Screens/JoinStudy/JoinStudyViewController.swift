//
//  JoinStudyViewController.swift
//  Hatnya
//
//  Created by Eve on 2022/07/19.
//

import UIKit
import FirebaseCore
import FirebaseFirestore

class JoinStudyViewController: UIViewController {
    
    let database = Firestore.firestore()
    var studyInfo = [StudyInfo]()
    
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
    
    func getGroupWithSameCode(completion: @escaping (Result<StudyInfo, Error>) -> Void) {
        database.collection("StudyGroup").whereField("code", isEqualTo: codeTextField.text as Any)
            .getDocuments { querySnapshot, err in
                if let err = err {
                    print("err: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        do {
                            let data = document.data()
                            guard let name = data["name"] as? String,
                                  let description = data["description"] as? String else { return }
                            
                            completion(.success(StudyInfo(name: name, description: description)))
                        }
                    }
                }
            }
    }
    
    private func searchStudyGroup() {
        getGroupWithSameCode { [weak self] results in
            switch results {
            case .success(let info):
                self?.searchResultView.backgroundColor = .systemGray6
                self?.studyGroupName.text = info.name
                self?.studyGroupDescription.text = info.description
            case .failure(let error):
                print(error)
            }
        }
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
