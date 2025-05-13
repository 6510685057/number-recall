//import SwiftUI
//
//struct GameView: View {
//    @StateObject var viewModel = GameViewModel()
//
//    var body: some View {
//        VStack(spacing: 20) {
//            // Header
//            HStack {
//                Text("Level \(viewModel.game.currentLevel)")
//                    .font(.title2)
//                Spacer()
//                Text("Time: \(viewModel.timerValue)")
//                    .foregroundColor(viewModel.timerValue > 3 ? .black : .red)
//                    .font(.headline)
//            }
//            .padding(.horizontal)
//
//            // ตัวเลขเป้าหมาย
//            HStack(spacing: 10) {
//                ForEach(viewModel.game.targetNumbers, id: \.self) { num in
//                    Text("\(num)")
//                        .font(.title)
//                        .frame(width: 50, height: 50)
//                        .background(Color.blue.opacity(0.2))
//                        .cornerRadius(8)
//                }
//            }
//
//            // ช่องกรอกคำตอบ
//            HStack(spacing: 10) {
//                ForEach(0..<viewModel.game.targetNumbers.count, id: \.self) { i in
//                    Text(viewModel.userInput.count > i ? "\(viewModel.userInput[i])" : "_")
//                        .font(.title)
//                        .frame(width: 50, height: 50)
//                        .background(Color.pink.opacity(0.2))
//                        .cornerRadius(8)
//                }
//            }
//
//            // Numpad
//            VStack(spacing: 10) {
//                ForEach([["1","2","3"], ["4","5","6"], ["7","8","9"], ["←", "0", "✓"]], id: \.self) { row in
//                    HStack(spacing: 20) {
//                        ForEach(row, id: \.self) { item in
//                            Button(action: {
//                                viewModel.handleNumpadInput(item)
//                            }) {
//                                Text(item)
//                                    .frame(width: 60, height: 60)
//                                    .font(.title2)
//                                    .background(Color(red: 255/255, green: 177/255, blue: 239/255))
//                                    .foregroundColor(.black)
//                                    .cornerRadius(12)
//                            }
//                        }
//                    }
//                }
//            }
//
//            Spacer()
//        }
//        .padding()
//        .onAppear {
//            viewModel.startNewLevel()
//        }
//    }
//}
//
//
//#Preview {
//    GameView()
//}
//import SwiftUI
//
//struct GameView: View {
//    @StateObject private var viewModel: GameViewModel
//    @StateObject var rankingViewModel: RankingViewModel
//
//    init(viewModel: @autoclosure @escaping () -> GameViewModel = GameViewModel()) {
//        _viewModel = StateObject(wrappedValue: viewModel())
//    }
//
//    var body: some View {
//        VStack(spacing: 20) {
//            HStack {
//                Button(action: {
////                    viewModel.mainView() //รอใส่
//                }) {
//                    Image(systemName: "house.fill")
//                        .foregroundColor(.black)
//                        .padding(10)
//                }
//                    
//
//                Spacer()
//
//                Text("Level \(viewModel.game.currentLevel)")
//                    .font(.headline)
//                    .foregroundColor(.black)
//
//                Spacer()
//
//                Text("Max: \(viewModel.maxLevel)")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//            .padding()
//            .background(Color.yellow.opacity(0.3))
//
//       
//            Text("Time: \(viewModel.timerValue)")
//                .font(.system(size: 40, weight: .bold))
//                .foregroundColor(viewModel.timerValue > 3 ? .black : .red)
//
//            
//            HStack(spacing: 12) {
//                ForEach(viewModel.game.targetNumbers, id: \.self) { num in
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 12)
//                            .fill(Color.blue.opacity(0.2))
//                            .frame(width: 70, height: 100)
//
//                        if viewModel.showCards {
//                            Text("\(num)")
//                                .font(.largeTitle)
//                                .foregroundColor(.black)
//                        } else {
//                            Image(systemName: "questionmark")
//                                .font(.title)
//                                .foregroundColor(.gray)
//                        }
//                    }
//                }
//            }
//
//        
//            HStack(spacing: 12) {
//                ForEach(0..<viewModel.game.targetNumbers.count, id: \.self) { i in
//                    Text(viewModel.userInput.count > i ? "\(viewModel.userInput[i])" : "_")
//                        .font(.largeTitle)
//                        .frame(width: 70, height: 70)
//                        .background(Color.pink.opacity(0.2))
//                        .cornerRadius(12)
//                }
//            }
//
//            Spacer()
//
//        
//            VStack(spacing: 10) {
//                ForEach([["1","2","3"], ["4","5","6"], ["7","8","9"], ["←", "0", "✓"]], id: \.self) { row in
//                    HStack(spacing: 20) {
//                        ForEach(row, id: \.self) { item in
//                            Button(action: {
//                                viewModel.handleNumpadInput(item)
//                            }) {
//                                Text(item)
//                                    .frame(width: 70, height: 70)
//                                    .font(.title)
//                                    .background(Color(red: 255/255, green: 177/255, blue: 239/255))
//                                    .foregroundColor(.black)
//                                    .cornerRadius(14)
//                            }
//                            .disabled(viewModel.showCards)
//                            .opacity(viewModel.showCards ? 0.5 : 1.0)
//                        }
//                    }
//                }
//            }
//            .padding(.bottom, 30)
//        }
//        .padding(.horizontal)
//        .frame(maxHeight: .infinity, alignment: .top)
//        .onAppear {
//            viewModel.startNewLevel()
//        }
//
//       
//        .sheet(isPresented: $viewModel.showSuccessScreen) {
//            SuccessView(
//                onNext: {
//                    viewModel.showSuccessScreen = false
//                    viewModel.startNewLevel()
//                },
//                onHome: {
////                    viewModel.mainView()
//                }
//            )
//        }
//
//        .sheet(isPresented: $viewModel.showFailScreen) {
//            FailView(
//                onRetry: {
//                    viewModel.showFailScreen = false
//                    viewModel.startNewLevel()
//                },
//                onHome: {
//                    //viewModel.mainView()
//                }
//            )
//        }
//    }
//}
//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(viewModel: GameViewModel(
//            targetNumbers: [1, 2, 3, 4],
//            currentLevel: 2,
//            timeLimit: 5,
//            maxLevel: 5,
//            forPreview: true
//        ))
//    }
//}
import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    @StateObject var rankingViewModel: RankingViewModel

    init(viewModel: @autoclosure @escaping () -> GameViewModel = GameViewModel(),
         rankingViewModel: @autoclosure @escaping () -> RankingViewModel = RankingViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel())
        _rankingViewModel = StateObject(wrappedValue: rankingViewModel())
    }

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                            Button(action: {
                                // ใส่ action ที่ต้องการ
                            }) {
                                Image(systemName: "house.fill")
                                    .foregroundColor(.black)
                                    .padding(10)
                            }
                            
                            Spacer()
                            
                            Text("Level \(viewModel.game.currentLevel)")
                                .font(.headline)
                                .foregroundColor(.black)
                            
                            Spacer()
                            
                            Text("Max: \(viewModel.maxLevel)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .padding(.trailing, 20) // เพิ่มระยะห่างจากขอบขวา
                        }
                        .padding(.top, 0) // ลดพื้นที่ด้านบน
                        .background(Color.yellow.opacity(0.3))
                        .frame(maxHeight: .infinity, alignment: .top)

            Text("Time: \(viewModel.timerValue)")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(viewModel.timerValue > 3 ? .black : .red)

            HStack(spacing: 12) {
                ForEach(viewModel.game.targetNumbers, id: \.self) { num in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.blue.opacity(0.2))
                                .frame(width: 70, height: 100)

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

            HStack(spacing: 12) {
                ForEach(0..<viewModel.game.targetNumbers.count, id: \.self) { i in
                    Text(viewModel.userInput.count > i ? "\(viewModel.userInput[i])" : "_")
                        .font(.largeTitle)
                        .frame(width: 70, height: 70)
                        .background(Color.pink.opacity(0.2))
                        .cornerRadius(12)
                }
            }

            Spacer()

            VStack(spacing: 10) {
                ForEach([["1","2","3"], ["4","5","6"], ["7","8","9"],["←", "0", "✓"]], id: \.self) { row in
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
        }
        .sheet(isPresented: $viewModel.showSuccessScreen) {
            SuccessView(
                onNext: {
                    viewModel.showSuccessScreen = false
                    viewModel.startNewLevel()
                },
                onHome: {
                    viewModel.startNewLevel() // หรือกลับหน้า main
                },
                rankingViewModel: rankingViewModel,
                viewModel: viewModel
            )
        }
        .sheet(isPresented: $viewModel.showFailScreen) {
            FailView(
                onRetry: {
                    viewModel.showFailScreen = false
                    viewModel.startNewLevel()
                },
                onHome: {
                    viewModel.startNewLevel()
                },
                viewModel: viewModel,
                rankingViewModel: rankingViewModel
            )
        }
    }
}

// PreviewProvider
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(), rankingViewModel: RankingViewModel())
            .previewLayout(.sizeThatFits) // จัดขนาดพรีวิวให้เหมาะสม
            .padding()  // เพิ่ม padding เพื่อให้ขอบไม่ชนกับขอบ
    }
}
