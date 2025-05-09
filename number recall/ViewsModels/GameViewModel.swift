//
//  GameViewModel.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.
//

import Foundation
import SwiftUI



class GameViewModel: ObservableObject {
    @Published var game = GameModel(targetNumbers: [], currentLevel: 1, timeLimit: 5)
    @Published var timerValue: Int = 0
    @Published var isCounting = false
    @Published var userInput: [Int] = []

    var timer: Timer?

    func startNewLevel() {
        game.targetNumbers = (0..<4).map { _ in Int.random(in: 0...9) }
        userInput = []
        timerValue = game.timeLimit
        isCounting = true

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
            } else {
                self.timer?.invalidate()
                self.isCounting = false
                // ไปหน้าใส่คำตอบหรือเช็คอัตโนมัติ
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
            checkAnswer()
        default:
            if let number = Int(value), userInput.count < game.targetNumbers.count {
                userInput.append(number)
            }
        }
    }

    func checkAnswer() {
        if userInput == game.targetNumbers {
            print("✅ Correct!")
            // ไปด่านต่อ หรือแสดง Passed
        } else {
            print("❌ Incorrect!")
            // แจ้งผิด ลองใหม่
        }
    }

    func stopTimer() {
        timer?.invalidate()
        isCounting = false
    }
}
