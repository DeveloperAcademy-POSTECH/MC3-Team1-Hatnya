//
//  StudyRoomViewModel.swift
//  Hatnya
//
//  Created by Mingwan Choi on 2022/07/30.
//

import Combine

import FirebaseFirestore
import FirebaseFirestoreSwift

class StudyRoomViewModel {
    @Published private(set) var currentCount: Int = 0
    @Published private(set) var userTaskList: [Member] = []
    var cancelBag = Set<AnyCancellable>()

    init(studyUid: String) {
        fetchCurrentStudyCount(studyUid: studyUid)
    }

    func clearUserTaskList() {
        userTaskList.removeAll()
    }

    func increaseCurrentCount() {
        currentCount += 1
    }

    func decreaseCurrentCount() {
        currentCount -= 1
    }

    func fetchCurrentStudyCount(studyUid: String) {
        let firestoreDb = Firestore.firestore()
        firestoreDb
            .collection("StudyGroup")
            .document(studyUid)
            .getDocument(as: FirebaseStudyInfo.self, completion: { result in
            switch result {
            case .success(let info):
                // FIXME: 현재날짜로 부터 계산하면 1주차라서 강제로 3주차를 주기 위해 currentCount를 3으로 대입함.
                self.currentCount = 3
                self.fetchSnapShotMemberList(studyUid: studyUid, cycle: 3)
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

    func fetchSnapShotMemberList(studyUid: String, cycle: Int) {
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
                        .whereField("count", isEqualTo: cycle)
                        .getDocuments { querySnapshot, err in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            guard let snapshot = querySnapshot else { return }
                            for homeworkDocument in snapshot.documents {
                                homeworkDocument.reference.addSnapshotListener { snapshot, err in
                                    snapshot?.reference.getDocument(as: HomeworkTask.self) { result in
                                        switch result {
                                        case .success(let homework):
                                            let isContain = self.userTaskList.contains { $0.uid == uid }
                                            if !isContain {
                                                self.userTaskList.append(Member(uid: uid, nickname: name, homeworks: homework.list))
                                            }
                                        case .failure(let err):
                                            print(err)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}
