import Foundation
import Firebase

struct Ranking: Identifiable {
    var id: String
    var name: String
    var level: Int
}

class RankingViewModel: ObservableObject {
    @Published var rankings: [Ranking] = []
    
    private var db = Firestore.firestore()
    
    func fetchLeaderboard() {
        db.collection("users") // 🔁 เปลี่ยนจาก "rankings" เป็น "users"
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

struct Player: Identifiable {
    var id: String
    var name: String
    var level: Int
}
