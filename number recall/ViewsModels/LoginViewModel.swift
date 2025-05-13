//
//  LoginViewModel.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.
//

import Firebase
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    func saveUser(id: String, name: String, age: String) {
        let userRef = db.collection("users").document(id)

        userRef.setData([
            "name": name,
            "age": age,
            "level": 1
        ]) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("User successfully saved!")
            }
        }
    }


    func updateLevel(name: String, newLevel: Int) {
        let userRef = db.collection("users").document(name)
        
        userRef.updateData([
            "level": newLevel
        ]) { error in
            if let error = error {
                print("Error updating level: \(error)")
            } else {
                print("Level successfully updated!")
            }
        }
    }
}
