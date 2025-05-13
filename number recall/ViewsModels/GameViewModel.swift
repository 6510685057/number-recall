//
//  GameViewModel.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.


//import Foundation
//import Combine
//import FirebaseFirestore
//
//class GameViewModel: ObservableObject {
//    @Published var game: GameModel
//    @Published var timerValue: Int
//    @Published var isCounting = false
//    @Published var userInput: [Int] = []
//    @Published var maxLevel: Int
//    @Published var showCards: Bool = true
//    @Published var showSuccessScreen: Bool = false
//    @Published var showFailScreen: Bool = false
//
//
//
//    var timer: Timer?
//    private var db = Firestore.firestore()
//
//    init(
//        targetNumbers: [Int] = [],
//        currentLevel: Int = 1,
//        timeLimit: Int = 5,
//        maxLevel: Int = 1,
//        forPreview: Bool = false
//    ) {
//        self.game = GameModel(targetNumbers: targetNumbers, currentLevel: currentLevel, timeLimit: timeLimit)
//        self.timerValue = timeLimit
//        self.maxLevel = maxLevel
//        self.userInput = []
//
//        // ปิดการทำงานของ Timer ใน Preview
//        if !forPreview {
//            startNewLevel()
//        }
//    }
//
//    func startNewLevel() {
//        game.targetNumbers = (0..<4).map { _ in Int.random(in: 0...9) }
//        userInput = []
//        timerValue = game.timeLimit
//        isCounting = true
//        showCards = true
//
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            if self.timerValue > 0 {
//                self.timerValue -= 1
//            } else {
//                self.timer?.invalidate()
//                self.isCounting = false
//                self.showCards = false
//            }
//        }
//    }
//
//
//
//    func handleNumpadInput(_ value: String) {
//        switch value {
//        case "←":
//            if !userInput.isEmpty {
//                userInput.removeLast()
//            }
//        case "✓":
//            showCards = true
//            checkAnswer()
//        default:
//            if let number = Int(value), userInput.count < game.targetNumbers.count {
//                userInput.append(number)
//            }
//        }
//    }
//
//
//    func checkAnswer() {
//        if userInput == game.targetNumbers {
//            game.currentLevel += 1
//            if game.currentLevel > maxLevel {
//                maxLevel = game.currentLevel
//            }
//            showSuccessScreen = true
//        } else {
//            showFailScreen = true
//        }
//    }
//
//    
//
//    func stopTimer() {
//        timer?.invalidate()
//        isCounting = false
//    }
//    func updateLevelInDatabase(playerName: String, newLevel: Int) {
//        let userRef = db.collection("users").document(playerName)
//        
//        userRef.updateData([
//            "level": newLevel
//        ]) { error in
//            if let error = error {
//                print("Error updating level: \(error)")
//            } else {
//                print("Level successfully updated!")
//            }
//        }
//    }
//
//}
import Foundation
import Firebase

class GameViewModel: ObservableObject {
    @Published var game: GameModel
    @Published var timerValue: Int
    @Published var isCounting = false
    @Published var userInput: [Int] = []
    @Published var maxLevel: Int
    @Published var showCards: Bool = true
    @Published var showSuccessScreen: Bool = false
    @Published var showFailScreen: Bool = false
  


    var timer: Timer?

    init(targetNumbers: [Int] = [],
         currentLevel: Int = 1,
         timeLimit: Int = 5,
         maxLevel: Int = 1,
         forPreview: Bool = false) {
        self.game = GameModel(targetNumbers: targetNumbers, currentLevel: currentLevel, timeLimit: timeLimit)
        self.timerValue = timeLimit
        self.maxLevel = maxLevel
        self.userInput = []

        // ปิดการทำงานของ Timer ใน Preview
        if !forPreview {
            startNewLevel()
        }
    }

    func startNewLevel() {
        game.targetNumbers = (0..<4).map { _ in Int.random(in: 0...9) }
        userInput = []
        timerValue = game.timeLimit
        isCounting = true
        showCards = true

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
            } else {
                self.timer?.invalidate()
                self.isCounting = false
                self.showCards = false
            }
        }
    }

    func handleNumpadInput(_ value: String) {
        switch value {
        case "←":
            if !userInput.isEmpty {
                userInput.removeLast()
            }
        case "✓":
            showCards = true
            checkAnswer()
        default:
            if let number = Int(value), userInput.count < game.targetNumbers.count {
                userInput.append(number)
            }
        }
    }
    
   

//    func checkAnswer() {
//        if userInput == game.targetNumbers {
//            game.currentLevel += 1
//            if game.currentLevel > maxLevel {
//                maxLevel = game.currentLevel
//            }
//            showSuccessScreen = true
//            // Save the new level to Firestore
//            updateLevelInDatabase(userID: "userID", newLevel: game.currentLevel) // ใส่ userID จริงที่คุณเก็บไว้
//        } else {
//            showFailScreen = true
//        }
//    }
    func checkAnswer() {
        if userInput == game.targetNumbers {
            game.currentLevel += 1
            if game.currentLevel > maxLevel {
                maxLevel = game.currentLevel
            }
            showSuccessScreen = true

            // ✅ ดึง userID จาก UserDefaults
            let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
            updateLevelInDatabase(userID: userID, newLevel: game.currentLevel)

        } else {
            showFailScreen = true
        }
    }



    func stopTimer() {
        timer?.invalidate()
        isCounting = false
    }

    func updateLevelInDatabase(userID: String, newLevel: Int) {
        let userRef = Firestore.firestore().collection("users").document(userID)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                userRef.updateData(["level": newLevel]) { error in
                    if let error = error {
                        print("Error updating level: \(error.localizedDescription)")
                    } else {
                        print("Level successfully updated for \(userID)")
                    }
                }
            } else {
                print("No such document in Firestore.")
            }
        }
    }



}
