//
//  StudyRoomViewModel.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/30.
//

import Combine

import FirebaseFirestore
import FirebaseFirestoreSwift

struct HomeworkTask: Codable {
    var cycle: Int
    var list: [Homework]
}

class StudyRoomViewModel {
    @Published var userTaskList: [Member] = []

    init(studyUid: String) {
        fetchMemberList(studyUid: studyUid, cycle: 3)
    }
    
    func clearUserTaskList() {
        userTaskList.removeAll()
    }

    func fetchMemberList(studyUid: String, cycle: Int) {
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
                for document in snapshot.documents {
                    let data = document.data()
                    let uid = data["uid"] as? String ?? ""
                    let name = data["nickname"] as? String ?? ""
                    document.reference.collection("Homeworks")
                        .whereField("cycle", isEqualTo: cycle)
                        .getDocuments { querySnapshot, err in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            guard let snapshot = querySnapshot else { return }
                            for document in snapshot.documents {
                                document.reference.getDocument(as: HomeworkTask.self, completion: { result in
                                    switch result {
                                    case .success(let homework):
                                        self.userTaskList.append(Member(uid: uid, nickname: name, homeworks: homework.list))
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
}
