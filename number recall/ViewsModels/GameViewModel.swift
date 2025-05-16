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
        
        if !forPreview {
            startNewLevel()
        }
    }
    
    // 📈 กำหนดระดับความยากตามด่าน
    func getLevelConfiguration(for level: Int) -> (count: Int, time: Int, maxDigit: Int) {
        switch level {
        case 1:
            return (3, 6, 5)
        case 2:
            return (3, 5, 7)
        case 3:
            return (4, 5, 9)
        case 4:
            return (4, 4, 9)
        case 5:
            return (5, 5, 9)
        case 6:
            return (5, 4, 9)
        case 7:
            return (6, 5, 9)
        case 8:
            return (6, 4, 9)
        case 9:
            return (6, 3, 9)
        case 10:
            return (7, 4, 9)
        default:
            return (7, 3, 9)
        }
    }
    
    func startNewLevel() {
        let config = getLevelConfiguration(for: game.currentLevel)
        game.timeLimit = config.time
        timerValue = config.time

        game.targetNumbers = (0..<config.count).map { _ in Int.random(in: 0...config.maxDigit) }
        userInput = []
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
