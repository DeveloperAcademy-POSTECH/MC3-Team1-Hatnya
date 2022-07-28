//
//  WriteNicknameViewController.swift
//  Hatnya
//
//  Created by 비트 on 2022/07/19.
//

import FirebaseFirestore
import SwiftUI
import UIKit

final class WriteNicknameViewController: UIViewController {
    let firestore = Firestore.firestore()
    var studyGroup = StudyGroup(members: [],
                                name: "이름 없음",
                                code: "no code",
                                description: "설명 없음",
                                cycle: StudyCycle(cycle: 1, weekDay: ["화"]),
                                createdAt: nil)
    
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
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.isEnabled = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonTapHandler), for: .touchUpInside)
        return button
    }()
    
    @objc
    func nextButtonTapHandler(sender: UIButton) {
        studyGroup.members.append(Member(nickname: inputTextField.text ?? "이름 없음", homeworks: []))
        print(studyGroup)
        
        let studyGroupUUID = UUID()
        let cycleGroupUUID = UUID()
        let membersGroupUUID = UUID()
        
        let studyGroupData: [String: Any] = [
            "code": studyGroup.code,
            "createdAt": Timestamp(date: Date()),
            "description": studyGroup.description,
            "name": studyGroup.name
        ]
        
        let cycleData: [String: Any] = [
            "cycle": studyGroup.cycle.cycle,
            "weekday": studyGroup.cycle.weekDay
        ]
        
        let membersData: [String: Any] = [
            "nickname": studyGroup.cycle.cycle,
            "uid": UIDevice.current.identifierForVendor!.uuidString
        ]
    
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString).setData(studyGroupData)
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString)
            .collection("Cycle").document(cycleGroupUUID.uuidString).setData(cycleData)
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString)
            .collection("Members").document(membersGroupUUID.uuidString).setData(membersData)
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureAddSubviews()
        configureConstraints()
        configureTextField()
        print(studyGroup)
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
        
        [titleLabel, inputTextField, deleteButton, nextButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    private func configureConstraints() {
        guard let view = self.view else { return }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
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
        inputTextField.underlined(viewSize: inputTextField.bounds.width, color: .systemGray)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text == nil || textField.text == "" {
            nextButton.backgroundColor = .systemGray4
            nextButton.isEnabled = false
        } else {
            nextButton.backgroundColor = .systemBlue
            nextButton.isEnabled = true
        }
    }
    
}

struct WriteNicknameViewControllerPreview: PreviewProvider {

    static var previews: some View {
        WriteNicknameViewController().toPreview()
    }

}
