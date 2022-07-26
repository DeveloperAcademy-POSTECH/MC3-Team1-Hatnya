//
//  StudyListViewController.swift
//  Hatnya
//
//  Created by kelly on 2022/07/18.
//

import FirebaseCore
import FirebaseFirestore
import UIKit

final class StudyListViewController: UIViewController {
    
    @IBAction private func showActionSheetButton(_ sender: Any) {
        showActionSheet()
    }
    
    let firestore = Firestore.firestore()
    var studyGroup = [StudyGroup]()
    
    private lazy var emptyStudyLabel: UILabel = {
        let label = UILabel()
        label.text = "스터디 그룹이 없습니다."
        label.font = .systemFont(ofSize: 17)
        label.textColor = .gray
        label.textAlignment = .center
        
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        render()
        addUid()
        fetchStudyGroups()
    }
    
    private func render() {
        if StudyGroup.sampleData.isEmpty {
            view.addSubview(emptyStudyLabel)
            let safeArea = view.safeAreaLayoutGuide
            
            emptyStudyLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyStudyLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            emptyStudyLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        }
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let enterStudyButton = UIAlertAction(title: "스터디 참여하기", style: .default) { _ in
            //TODO: 스터디 코드 입력 창으로 연결
        }
        let createStudyButton = UIAlertAction(title: "스터디 생성하기", style: .default) { _ in
            //TODO: 스터디 생성 창으로 연결
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        actionSheet.addAction(enterStudyButton)
        actionSheet.addAction(createStudyButton)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func addUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        let uidIndex = uuid.index(uuid.startIndex, offsetBy: 5)
        let uid = String(uuid[...uidIndex])
        print("addUid: \(uid)")
        UserDefaults.standard.set(uid, forKey: "User")
    }
    
    private func fetchStudyGroups() {
        var count: Int = 0
        
        firestore.collectionGroup("Members")
            .whereField("uid", isEqualTo: UserDefaults.standard.string(forKey: "User") ?? "")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for memberDocument in querySnapshot!.documents {
                        let studyGroupId = memberDocument.reference.parent.parent?.documentID ?? ""
                        let docRef = self.firestore.collection("StudyGroup").document(studyGroupId)
                        
                        docRef.getDocument { [self] (document, _) in
                            if let document = document, document.exists {
                                studyGroup[count].name = document.get("name") as? String ?? ""
                                studyGroup[count].description = document.get("description") as? String ?? ""
                                print(studyGroup[count].name)
                                print(studyGroup[count].description)
                                count += 1
                            } else {
                                print("StudyGroup document does not exist (failed to get study groups list)")
                            }
                        }
                    }
                }
            }
    }
}

extension StudyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudyGroup.sampleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudyListTableViewCell.identifier,
                                                       for: indexPath) as? StudyListTableViewCell else {
            return UITableViewCell()
        }
        
        let dataSource = StudyGroup(members: StudyGroup.sampleData[indexPath.row].members,
                                    name: StudyGroup.sampleData[indexPath.row].name,
                                    code: StudyGroup.sampleData[indexPath.row].code,
                                    description: StudyGroup.sampleData[indexPath.row].description,
                                    cycle: StudyGroup.sampleData[indexPath.row].cycle,
                                    createdAt: StudyGroup.sampleData[indexPath.row].createdAt)
        cell.configure(with: dataSource)
        
        return cell
    }
}
