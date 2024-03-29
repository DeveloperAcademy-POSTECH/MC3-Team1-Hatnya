//
//  NetworkManager.swift
//  Hatnya
//
//  Created by 리아 on 2022/08/01.
//

import Combine
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class NetworkManager {

    private let firestore = Firestore.firestore()
    // TODO: study id UserDefaults 저장 또는 뷰컨트롤러로부터 데이터 전달하여 하드 코딩 제거
    var studyId = "w2sEujplXcqubgaYYUdZ"

    enum NetworkError: Error {
        case encodingError(Error)
        case decodingError(Error)
        case badURL(Error)
        case unknown
    }

    func getHomeworkPath(count: Int, completionHandler: @escaping (String) -> Void) {
        let uid = UserDefaults.standard.string(forKey: "User") ?? ""
        let studyId = self.studyId
        var userId = ""
        var homeworkId = ""

        firestore.collection("StudyGroup/\(studyId)/Members")
            .getDocuments { querySnapshot, _ in
            guard let documents = querySnapshot?.documents else { return }

            documents.forEach { snapshot in
                guard let idData = snapshot.data()["uid"] as? String else { return }
                if uid == idData {
                    userId = snapshot.documentID

                    snapshot.reference.collection("Homeworks")
                        .getDocuments { querySnapshot, _ in
                        guard let documents = querySnapshot?.documents else { return }
                        documents.forEach { snapshot in
                            guard let countData = snapshot.data()["count"] as? Int else { return }
                            if count == countData {
                                homeworkId = snapshot.documentID
                                completionHandler("StudyGroup/\(studyId)/Members/\(userId)/Homeworks/\(homeworkId)")
                            }
                        }
                    }
                }
            }
        }
    }

    func getAllMemeberPath(count: Int, completion: @escaping (String, [Homework]) -> Void) {
        let studyId = self.studyId
        
        firestore.collection("StudyGroup/\(studyId)/Members")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                documents.forEach { snapshot in
                    let userId = snapshot.documentID
                    
                    snapshot.reference.collection("Homeworks")
                        .getDocuments { querySnapshot, _ in
                            guard let documents = querySnapshot?.documents else { return }
                            documents.forEach { snapshot in
                                guard let countData = snapshot.data()["count"] as? Int else { return }
                                guard let homeworkListData = snapshot.data()["list"] as? [Homework] else { return }
                                if count == countData {
                                    let homeworkId = snapshot.documentID
                                    completion("StudyGroup/\(studyId)/Members/\(userId)/Homeworks/\(homeworkId)", homeworkListData)
                                }
                            }
                        }
                }
            }
    }
    
    func post<T: Encodable>(with data: T, path: String) {
        do {
            let encodeData = try Firestore.Encoder().encode(data)

            firestore.document(path)
                .setData(encodeData) { error in
                if let error = error {
                    print(NetworkError.badURL(error))
                }
            }
        } catch {
            print(NetworkError.encodingError(error))
        }
    }

    func get<T: Decodable>(for type: T.Type, path: String, completionHandler: @escaping (T) -> Void) {
        firestore.document(path)
            .addSnapshotListener { snapshot, error in
            guard let document = snapshot else { return }
            do {
                let data = try document.data(as: type)
                completionHandler(data)
            } catch {
                print(NetworkError.decodingError(error))
            }
        }
    }

}
