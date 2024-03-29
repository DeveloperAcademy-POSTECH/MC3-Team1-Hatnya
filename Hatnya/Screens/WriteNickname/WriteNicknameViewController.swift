//
//  WriteNicknameViewController.swift
//  Hatnya
//
//  Created by 비트 on 2022/07/19.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import UIKit

final class WriteNicknameViewController: UIViewController {
    private let firestore = Firestore.firestore()
    var studyGroupDocumentId: String = ""
    
    var studyGroup = StudyGroup(members: [],
                                name: "이름 없음",
                                code: "no code",
                                description: "설명 없음",
                                cycle: StudyCycle(cycle: 1, weekDay: ["화"]),
                                createdAt: nil,
                                uid: "no uid")
    
    var initialHomeworkList: [Homework] = []
    
    var beforeWriteNicknameView: BeforeView = .createStudy
    
    enum BeforeView {
        case createStudy
        case joinStudy
    }
    
    var mode: Mode = .create
    
    enum Mode {
        case edit
        case create
        
        var titleText: String {
            switch self {
            case .create:
                return "스터디에서 사용할 닉네임을 입력하세요"
            case .edit:
                return "수정할 닉네임을 입력해 주세요"
            }
        }
        
        var nextButtonText: String {
            switch self {
            case .create:
                return "그룹 입장하기"
            case .edit:
                return "수정하기"
            }
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = mode.titleText
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
        button.setTitle(mode.nextButtonText, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 17)
        button.isEnabled = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(nextButtonTapHandler), for: .touchUpInside)
        return button
    }()
    
    @objc
    func nextButtonTapHandler(sender: UIButton) {
        if beforeWriteNicknameView == BeforeView.createStudy {
            createNewStudy()
        } else {
            storeMemberNickname()
        }
        
        self.presentingViewController?.viewWillAppear(true)
        self.presentingViewController?.dismiss(animated: true)
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.underlined(viewSize: textField.bounds.width, color: .systemBlue)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.underlined(viewSize: textField.bounds.width, color: .systemGray)
    }
    
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
    
    private func createNewStudy() {
        let studyGroupUUID = UUID()
        let memberUUID = UUID()
        
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
            "nickname": inputTextField.text ?? "이름 없음",
            "uid": UIDevice.current.identifierForVendor!.uuidString
        ]
        
        let homeworksData: [String: Any] = [
            "list": [],
            "count": 1
        ]
    
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString).setData(studyGroupData)
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString)
            .collection("Cycle").addDocument(data: cycleData)
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString)
            .collection("Members").document(memberUUID.uuidString).setData(membersData)
        firestore.collection("StudyGroup").document(studyGroupUUID.uuidString)
            .collection("Members").document(memberUUID.uuidString).collection("Homeworks").addDocument(data: homeworksData)
    }
    
    private func storeMemberNickname() {
        let memberId = UUID()
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let membersRef = firestore.collection("StudyGroup").document(studyGroupDocumentId)
                    .collection("Members").document(memberId.uuidString)
        let nickname = self.inputTextField.text
        
        self.initHomeworkList(studyUid: self.studyGroupDocumentId)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            membersRef.setData([
                "uid": uuid,
                "nickname": nickname ?? ""
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
            }
            
            do {
                var initialList: [Homework] = []
                self.initialHomeworkList.forEach { each in
                    initialList.append(Homework(id: "", name: each.name, isCompleted: false))
                }
                let updatedData = Homeworks(count: 3, list: initialList)
                let encodeData = try Firestore.Encoder().encode(updatedData)

                membersRef.collection("Homeworks").document()
                    .setData(encodeData) { error in
                    if let error = error {
                        print(error)
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func initHomeworkList(studyUid: String) {
        let firestoreDb = Firestore.firestore()
        firestoreDb
            .collection("StudyGroup")
            .document(studyUid)
            .collection("Members")
            .getDocuments { querySnapshot, err in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                guard let snapshot = querySnapshot else { return }
                snapshot.documents.first?.reference.collection("Homeworks")
                .whereField("count", isEqualTo: 3)
                .getDocuments { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        guard let snapshot = querySnapshot else { return }
                        for document in snapshot.documents {
                            document.reference.getDocument(as: HomeworkTask.self, completion: { result in
                                switch result {
                                case .success(let homework):
                                    self.initialHomeworkList = homework.list
                                case .failure(let err):
                                    print(err)
                                }
                            })
                        }
                    }
                }
            }
        }
    }
}

struct WriteNicknameViewControllerPreview: PreviewProvider {

    static var previews: some View {
        WriteNicknameViewController().toPreview()
    }

}
