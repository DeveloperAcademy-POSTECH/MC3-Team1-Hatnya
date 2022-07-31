//
//  NetworkManager.swift
//  Hatnya
//
//  Created by 리아 on 2022/08/01.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Foundation

final class NetworkManager {
    
    private let database = Firestore.firestore()
    
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
