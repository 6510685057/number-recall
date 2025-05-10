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
import Foundation
import FirebaseFirestore

class RankingViewModel: ObservableObject {
    @Published var players: [Player] = []

    init() {
        fetchLeaderboard()
    }

    func fetchLeaderboard() {
        let db = Firestore.firestore()
        db.collection("users")
            .order(by: "level", descending: true)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching leaderboard: \(error)")
                } else {
                    self.players = snapshot?.documents.compactMap { document in
                        let data = document.data()
                        let name = data["name"] as? String ?? "Unknown"
                        let level = data["level"] as? Int ?? 1
                        return Player(id: document.documentID, name: name, level: level)
                    } ?? []
                }
            }
    }
}

struct Player: Identifiable {
    var id: String
    var name: String
    var level: Int
}
