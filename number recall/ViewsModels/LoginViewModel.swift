import Firebase
import FirebaseFirestore

class LoginViewModel: ObservableObject {
    private var db = Firestore.firestore()
    
    func saveUser(id: String, name: String, age: String, icon: String){
        let userRef = db.collection("users").document(id)
        
        userRef.setData([
            "name": name,
            "age": age,
            "level": 1,
            "icon": icon
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
    func fetchUserLevel(id: String, completion: @escaping (Int?) -> Void) {
        let userRef = db.collection("users").document(id)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let level = document.data()?["level"] as? Int
                completion(level)
            } else {
                completion(nil)
            }
        }
    }
    
    struct UserProfile {
        var name: String
        var icon: String
    }
    
    func fetchUserProfile(id: String, completion: @escaping (UserProfile?) -> Void) {
        let userRef = db.collection("users").document(id)
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let name = document.data()?["name"] as? String ?? ""
                let icon = document.data()?["icon"] as? String ?? "star.fill"
                completion(UserProfile(name: name, icon: icon))
            } else {
                completion(nil)
            }
        }
    }
    
    func updateUserProfile(id: String, name: String, icon: String) {
        let userRef = db.collection("users").document(id)
        userRef.updateData([
            "name": name,
            "icon": icon
        ]) { error in
            if let error = error {
                print("Error updating profile: \(error)")
            } else {
                print("Profile updated successfully.")
            }
        }
    }
    
    
}
