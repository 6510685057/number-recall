import Foundation
import Firebase
import FirebaseAuth // ต้อง import เพื่อดึง user ปัจจุบัน

struct Ranking: Identifiable {
    var id: String
    var name: String
    var level: Int
}

class RankingViewModel: ObservableObject {
    @Published var rankings: [Ranking] = []
    
    // เพิ่ม property เก็บ user ปัจจุบัน
    @Published var currentUserID: String? = nil
    
    private var db = Firestore.firestore()
    
    init() {
        fetchCurrentUser()
    }
    
    func fetchCurrentUser() {
        // ดึง uid ของ user ที่ล็อกอิน Firebase Auth
        if let user = Auth.auth().currentUser {
            self.currentUserID = user.uid
        } else {
            self.currentUserID = nil
        }
    }
    
    func fetchLeaderboard() {
        db.collection("users")
            .order(by: "level", descending: true)
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching leaderboard: \(error.localizedDescription)")
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    print("No leaderboard data")
                    return
                }
                
                DispatchQueue.main.async {
                    self.rankings = documents.compactMap { doc in
                        let data = doc.data()
                        let id = doc.documentID
                        let name = data["name"] as? String ?? "Unknown"
                        let level = data["level"] as? Int ?? 0
                        return Ranking(id: id, name: name, level: level)
                    }
                }
            }
    }
}
