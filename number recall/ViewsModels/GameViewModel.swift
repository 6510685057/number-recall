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
    
    
    
    func checkAnswer() {
        if userInput == game.targetNumbers {
            game.currentLevel += 1
            if game.currentLevel > maxLevel {
                maxLevel = game.currentLevel
                let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
                updateLevelInDatabase(userID: userID, newLevel: maxLevel)
            }
            
            
            showSuccessScreen = true
            
            
            
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
                let currentLevelInDB = document.data()?["level"] as? Int ?? 1
                
                if newLevel > currentLevelInDB {
                    userRef.updateData(["level": newLevel]) { error in
                        if let error = error {
                            print("Error updating level: \(error.localizedDescription)")
                        } else {
                            print("Level successfully updated for \(userID) to \(newLevel)")
                        }
                    }
                } else {
                    print("No update needed. Current level in DB: \(currentLevelInDB), New level: \(newLevel)")
                }
            } else {
                print("No such document in Firestore.")
            }
        }
    }
    
    
    func restartFromLevelOne() {
        game.currentLevel = 1
        startNewLevel()
    }
    
    func loadMaxLevelFromDatabase() {
        let userID = UserDefaults.standard.string(forKey: "userID") ?? ""
        let userRef = Firestore.firestore().collection("users").document(userID)
        
        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let level = document.data()?["level"] as? Int ?? 1
                DispatchQueue.main.async {
                    self.maxLevel = level
                }
            } else {
                print("No such user to load maxLevel.")
            }
        }
    }
    
    
    
}
