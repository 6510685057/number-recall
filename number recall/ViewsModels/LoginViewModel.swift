//
//  LoginViewModel.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.
//

import Foundation
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    private let db = Firestore.firestore()

    func saveUser(name: String, age: String) {
        let userData: [String: Any] = [
            "name": name,
            "age": age,
            "timestamp": Date()
        ]

        db.collection("users").addDocument(data: userData) { error in
            if let error = error {
                print("Error adding user: \(error)")
            } else {
                print("User saved to Firestore")
            }
        }
    }
}
