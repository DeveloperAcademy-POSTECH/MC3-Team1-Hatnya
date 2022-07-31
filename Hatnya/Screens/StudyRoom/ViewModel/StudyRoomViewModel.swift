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

struct FirebaseStudyInfo: Codable {
    let name: String
    let code: String
    let createdAt: Date
    let description: String
}

class StudyRoomViewModel {
    @Published var currentCount: Int = 0
    @Published var userTaskList: [Member] = []
    var cancelBag = Set<AnyCancellable>()

    init(studyUid: String) {
        fetchCurrentStudyCount(studyUid: studyUid)
    }

    func clearUserTaskList() {
        userTaskList.removeAll()
    }

    func fetchCurrentStudyCount(studyUid: String) {
        let firestoreDb = Firestore.firestore()
        firestoreDb
            .collection("StudyGroup")
            .document(studyUid)
            .getDocument(as: FirebaseStudyInfo.self, completion: { result in
            switch result {
            case .success(let info):
//                self.currentCount = self.getCurrentStudyCount(to: info.createdAt)
                self.currentCount = 3
                self.fetchMemberList(studyUid: studyUid, cycle: 3)
            case .failure(let err):
                print(err)
            }
        })
    }
    
    func getCurrentStudyCount(to startDate: Date) -> Int {
        let oneDayTimeInterval: TimeInterval = 86_400
        let distance = startDate.distance(to: Date())
        let distanceDay = Int(distance / oneDayTimeInterval)
        let count = distanceDay / 7
        return count + 1
    }

    func fetchMemberList(studyUid: String, cycle: Int) {
        self.clearUserTaskList()
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
