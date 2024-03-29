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
    
    @IBOutlet private weak var tableView: UITableView!
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
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchStudyGroups()
    }
    
    private func render() {
        if studyGroup.isEmpty {
            view.addSubview(emptyStudyLabel)
            let safeArea = view.safeAreaLayoutGuide
            
            emptyStudyLabel.translatesAutoresizingMaskIntoConstraints = false
            emptyStudyLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
            emptyStudyLabel.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        }
    }
    
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: .none, message: .none, preferredStyle: .actionSheet)
        
        let enterStudyButton = UIAlertAction(title: "스터디 참여하기", style: .default) { [weak self] _ in
            let joinStudystoryboard = UIStoryboard(name: "JoinStudyView", bundle: nil)
            let joinStudyViewController = joinStudystoryboard.instantiateViewController(identifier: "JoinStudyView")
            let navigationController = UINavigationController(rootViewController: joinStudyViewController)
            navigationController.navigationBar.topItem?.title = ""
            self?.present(navigationController, animated: true, completion: nil)
        }
        let createStudyButton = UIAlertAction(title: "스터디 생성하기", style: .default) { [weak self] _ in
            let createViewVontroller = CreateStudyViewController()
            let navigationController = UINavigationController(rootViewController: createViewVontroller)
            navigationController.navigationBar.topItem?.title = ""
            self?.present(navigationController, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
            
        }
        
        actionSheet.addAction(enterStudyButton)
        actionSheet.addAction(createStudyButton)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    /// 기기의 UUID를 유저의 uid로 UserDefaults에 저장
    func addUid() {
        let uuid = UIDevice.current.identifierForVendor!.uuidString
        UserDefaults.standard.set(uuid, forKey: "User")
    }
    
    func fetchStudyGroups() {
        studyGroup = [StudyGroup]()
        // "Members" 컬렉션에서 (UserDefaults에 저장된 값 == uid)인 document만 필터링
        firestore.collectionGroup("Members")
            .whereField("uid", isEqualTo: UserDefaults.standard.string(forKey: "User") ?? "")
            .getDocuments { querySnapshot, err in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for memberDocument in querySnapshot!.documents {
                        // 가져온 "Member" document의 parent인 "StudyGroup"의 document에 접근
                        let studyGroupId = memberDocument.reference.parent.parent?.documentID ?? ""
                        let docRef = self.firestore.collection("StudyGroup").document(studyGroupId)
                        
                        docRef.getDocument { [self] document, _ in
                            if let document = document, document.exists {
                                // "StudyGroup"의 document에서 "StudyGroup"의 이름과 설명 가져오기
                                let studyGroupName = document.get("name") as? String ?? ""
                                let studyGroupDescription = document.get("description") as? String ?? ""
                                
                                // 기존 "StudyGroup" 객체에 append
                                studyGroup.append(StudyGroup(members: [],
                                                             name: studyGroupName, code: "", description: studyGroupDescription,
                                                             cycle: StudyCycle(cycle: 0, weekDay: []),
                                                             createdAt: Date(), uid: studyGroupId))
                                // firebase에서 데이터를 가져왔으므로 reload
                                tableView.reloadData()
                                emptyStudyLabel.text = ""
                            } else {
                                print("StudyGroup document does not exist (failed to get study groups list)")
                            }
                        }
                    }
                }
            }
    }
}

extension StudyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedStudyGroup = studyGroup[indexPath.row]
        let studyRoomViewController = StudyRoomViewController(selectedStudyGroup: selectedStudyGroup)
        navigationController?.pushViewController(studyRoomViewController, animated: true)
    }
}

extension StudyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudyListTableViewCell.identifier,
                                                       for: indexPath) as? StudyListTableViewCell else {
            return UITableViewCell()
        }
        
        let dataSource = StudyGroup(members: studyGroup[indexPath.row].members,
                                    name: studyGroup[indexPath.row].name,
                                    code: studyGroup[indexPath.row].code,
                                    description: studyGroup[indexPath.row].description,
                                    cycle: studyGroup[indexPath.row].cycle,
                                    createdAt: studyGroup[indexPath.row].createdAt,
                                    uid: studyGroup[indexPath.row].uid)
        cell.configure(with: dataSource)
        
        return cell
    }
}
