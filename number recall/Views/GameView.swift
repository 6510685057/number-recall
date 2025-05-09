//
//  GameView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()

    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Text("Level \(viewModel.game.currentLevel)")
                    .font(.title2)
                Spacer()
                Text("Time: \(viewModel.timerValue)")
                    .foregroundColor(viewModel.timerValue > 3 ? .black : .red)
                    .font(.headline)
            }
            .padding(.horizontal)

            // ตัวเลขเป้าหมาย
            HStack(spacing: 10) {
                ForEach(viewModel.game.targetNumbers, id: \.self) { num in
                    Text("\(num)")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(8)
                }
            }

            // ช่องกรอกคำตอบ
            HStack(spacing: 10) {
                ForEach(0..<viewModel.game.targetNumbers.count, id: \.self) { i in
                    Text(viewModel.userInput.count > i ? "\(viewModel.userInput[i])" : "_")
                        .font(.title)
                        .frame(width: 50, height: 50)
                        .background(Color.pink.opacity(0.2))
                        .cornerRadius(8)
                }
            }

            // Numpad
            VStack(spacing: 10) {
                ForEach([["1","2","3"], ["4","5","6"], ["7","8","9"], ["←", "0", "✓"]], id: \.self) { row in
                    HStack(spacing: 20) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                viewModel.handleNumpadInput(item)
                            }) {
                                Text(item)
                                    .frame(width: 60, height: 60)
                                    .font(.title2)
                                    .background(Color(red: 255/255, green: 177/255, blue: 239/255))
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                            }
                        }
                    }
                }
            }

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.startNewLevel()
        }
    }
}


#Preview {
    GameView()
}
