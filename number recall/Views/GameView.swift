import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    @StateObject var rankingViewModel: RankingViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.dismiss) private var dismissView


    var gridColumnCount: Int {
        if viewModel.game.targetNumbers.count >= 10 {
            return 5
        } else {
            return max(viewModel.game.targetNumbers.count, 1)
        }
    }

    init(viewModel: @autoclosure @escaping () -> GameViewModel = GameViewModel(),
         rankingViewModel: @autoclosure @escaping () -> RankingViewModel = RankingViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel())
        _rankingViewModel = StateObject(wrappedValue: rankingViewModel())
    }

    var body: some View {
        VStack(spacing: 6) {
            VStack(spacing: 4) {
                // แถบท็อปบาร์
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.black)
                            .padding(10)
                    }

                    Spacer()

                    Text(String(format: NSLocalizedString("level", comment: ""), viewModel.game.currentLevel))
                        .font(.headline)
                        .foregroundColor(.black)

                    Spacer()

                    Text(String(format: NSLocalizedString("max_level", comment: ""), viewModel.maxLevel))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
                .frame(maxWidth: .infinity)
                .background(Color.yellow.opacity(0.3))
                .edgesIgnoringSafeArea(.horizontal)

                // เวลาแสดงใต้แถบท็อปบาร์แบบชิดๆ
                Text(String(format: NSLocalizedString("time", comment: ""), viewModel.timerValue))
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(viewModel.timerValue > 3 ? .black : .red)
                    .padding(.top, 2)
            }
            .background(Color.yellow.opacity(0.3))
            Spacer()
            
            // การ์ดเลข
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: gridColumnCount), spacing: 12) {
                ForEach(Array(viewModel.game.targetNumbers.enumerated()), id: \.offset) { _, num in
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.2))
                            .frame(height: 100)

                        if viewModel.showCards {
                            Text("\(num)")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        } else {
                            Image(systemName: "questionmark")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .padding(.horizontal)

            // ช่องกรอกคำตอบ
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: gridColumnCount), spacing: 12) {
                ForEach(0..<viewModel.game.targetNumbers.count, id: \.self) { i in
                    Text(viewModel.userInput.count > i ? "\(viewModel.userInput[i])" : "_")
                        .font(.largeTitle)
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink.opacity(0.2))
                        .cornerRadius(12)
                }
            }
            .padding(.horizontal)

            Spacer()

            // Numpad
            VStack(spacing: 10) {
                ForEach([["1","2","3"], ["4","5","6"], ["7","8","9"], ["←", "0", "✓"]], id: \.self) { row in
                    HStack(spacing: 20) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                viewModel.handleNumpadInput(item)
                            }) {
                                Text(item)
                                    .frame(width: 70, height: 70)
                                    .font(.title)
                                    .background(Color(red: 255/255, green: 177/255, blue: 239/255))
                                    .foregroundColor(.black)
                                    .cornerRadius(14)
                            }
                            .disabled(viewModel.showCards)
                            .opacity(viewModel.showCards ? 0.5 : 1.0)
                        }
                    }
                }
            }
            .padding(.bottom, 30)
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.startNewLevel()
            viewModel.loadMaxLevelFromDatabase()
        }
        .sheet(isPresented: $viewModel.showSuccessScreen) {
            SuccessView(
                onNext: {
                    viewModel.showSuccessScreen = false
                    viewModel.startNewLevel()
                },
                onHome: {
                    viewModel.startNewLevel()
                },
                rankingViewModel: rankingViewModel,
                viewModel: viewModel
            )
        }
        .sheet(isPresented: $viewModel.showFailScreen) {
            FailView(
                onRetry: {
                    viewModel.showFailScreen = false
                    viewModel.restartFromLevelOne()
                },
                onHome: {
                    viewModel.showFailScreen = false
                    dismissView()  // ปิด GameView (sheet) กลับไปหน้าเมนหลัก
                },
                viewModel: viewModel,
                rankingViewModel: rankingViewModel
            )
        }

        .navigationBarBackButtonHidden(true)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(forPreview: true), rankingViewModel: RankingViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

