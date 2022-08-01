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
    
    private let database = Firestore.firestore()

    func homeworkPath(cycle: Int, completionHandler: @escaping (String) -> Void) {
        // TODO: study id UserDefaults 저장 또는 뷰컨트롤러로부터 데이터 전달하여 하드 코딩 제거
        let studyId = "w2sEujplXcqubgaYYUdZ"
        let uid = UserDefaults.standard.string(forKey: "User") ?? ""
        var userId = ""
        var homeworkId = ""
        
        database.collection("StudyGroup/\(studyId)/Members")
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
                                    guard let cycleData = snapshot.data()["cycle"] as? Int else { return }
                                    if cycle == cycleData {
                                        homeworkId = snapshot.documentID
                                        completionHandler("StudyGroup/\(studyId)/Members/\(userId)/Homeworks/\(homeworkId)")
                                    }
                                }
                            }
                    }
                }
            }
    }
    
    func post<T: Encodable>(with data: T, path: String) {
        do {
            let encodeData = try Firestore.Encoder().encode(data)
            
            database.document(path)
                .setData(encodeData) { error in
                    print("🚨", error as Any)
                }
        } catch {
            print("🚨", error)
        }
    }
    
    func fetch<T: Decodable>(for type: T.Type, path: String, completionHandler: @escaping (T) -> Void) {
        database.document(path)
            .addSnapshotListener { snapshot, error in
                guard let document = snapshot else { return }
                do {
                    let data = try document.data(as: type)
                    completionHandler(data)
                } catch {
                    print("🚨", error)
                }
            }
    }
    
}
