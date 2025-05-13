//
//  RankingViewModel.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 10/5/2568 BE.
//

//import Foundation
//import Firebase
//import Combine
//
//class RankingViewModel: ObservableObject {
//    @Published var rankingList: [User] = []
//    @Published var isLoading: Bool = false
//
//    func fetchRankingData() {
//        self.isLoading = true
//        let db = Firestore.firestore()
//
//        db.collection("rankings")
//            .order(by: "level", descending: true)
//            .getDocuments { (querySnapshot, error) in
//                self.isLoading = false
//                if let error = error {
//                    print("Error getting documents: \(error)")
//                } else {
//                    self.rankingList = querySnapshot?.documents.compactMap { document in
//                        try? document.data(as: User.self)
//                    } ?? []
//                }
//            }
//    }
//}
//import Foundation
//import FirebaseFirestore

//class RankingViewModel: ObservableObject {
//    @Published var players: [Player] = []
//
//    init() {
//        fetchLeaderboard()
//    }
//
//    func fetchLeaderboard() {
//        let db = Firestore.firestore()
//        db.collection("users")
//            .order(by: "level", descending: true)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching leaderboard: \(error)")
//                } else {
//                    self.players = snapshot?.documents.compactMap { document in
//                        let data = document.data()
//                        let name = data["name"] as? String ?? "Unknown"
//                        let level = data["level"] as? Int ?? 1
//                        return Player(id: document.documentID, name: name, level: level)
//                    } ?? []
//                }
//            }
//    }
//}
//
//struct Player: Identifiable {
//    var id: String
//    var name: String
//    var level: Int
//}

//import Foundation
//import Firebase
//
//class RankingViewModel: ObservableObject {
//    @Published var players: [Player] = []
//
//    func updateLevel(userID: String, newLevel: Int){
//        let db = Firestore.firestore()
//        db.collection("users").document(userID).updateData(["level": newLevel]) { error in
//            if let error = error {
//                print("Error updating level: \(error.localizedDescription)")
//            } else {
//                print("Level updated successfully for \(userID)")
//            }
//        }
//    }
//
//    func fetchLeaderboard() {
//        let db = Firestore.firestore()
//        db.collection("users")
//            .order(by: "level", descending: true)
//            .getDocuments { snapshot, error in
//                if let error = error {
//                    print("Error fetching leaderboard: \(error.localizedDescription)")
//                } else {
//                    self.players = snapshot?.documents.compactMap { document in
//                        let data = document.data()
//                        let name = data["name"] as? String ?? "Unknown"
//                        let level = data["level"] as? Int ?? 1
//                        return Player(id: document.documentID, name: name, level: level)
//                    } ?? []
//                }
//            }
//    }
//}
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
