import SwiftUI

struct SuccessView: View {
    var onNext: () -> Void
    var onHome: () -> Void
    @ObservedObject var rankingViewModel: RankingViewModel
    @ObservedObject var viewModel: GameViewModel  // เพิ่มตัวแปรนี้
<<<<<<< HEAD
    @State private var isNextActive = false  // สถานะการนำทางไปหน้า GameView
    @State private var isHomeActive = false   // สถานะการนำทางไปหน้า MainView

    var body: some View {
        NavigationStack { // ใช้ NavigationStack
            ZStack {
                // ใช้พื้นหลังแบบ Gradient ครอบเต็มจอ
                LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)  // ให้พื้นหลังครอบคลุมเต็มหน้าจอ

                VStack {
                    Text("YOU DID IT!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, 30)
                    
                    // ปุ่ม Next และ Home
                    HStack(spacing: 30) {
                        // ปุ่ม Home จะอยู่ทางซ้าย
                        Button(action: {
                            isHomeActive = true  // เมื่อคลิกปุ่ม Home
                        }) {
                            Image(systemName: "house.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.pink.opacity(0.7))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }

                        // ปุ่ม Next จะอยู่ทางขวา
                        Button(action: {
                            rankingViewModel.updateLevel(userID: "userID", newLevel: viewModel.game.currentLevel)
                            viewModel.showSuccessScreen = false
                            viewModel.startNewLevel()
                            isNextActive = true  // เมื่อคลิกปุ่ม Play Next
                        }) {
                            Text("Play Next")
                                .font(.title3)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.yellow.opacity(0.7))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                        }
                    }
                    .padding(.top, 40)
                }
                .padding()
            }
            .navigationDestination(isPresented: $isHomeActive) {
                MainView()  // หน้า MainView
            }
            .navigationDestination(isPresented: $isNextActive) {
                GameView()  // หน้า GameView
            }
        }
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        // สร้าง Mock ViewModel สำหรับพรีวิว
        let mockRankingViewModel = RankingViewModel()
        
        // สร้าง Mock GameViewModel
        let mockGameViewModel = GameViewModel(targetNumbers: [], currentLevel: 1, timeLimit: 5, maxLevel: 1)

        // สร้าง SuccessView และแนบ ViewModel
        return SuccessView(onNext: {
            print("Next tapped")
        }, onHome: {
            print("Home tapped")
        }, rankingViewModel: mockRankingViewModel, viewModel: mockGameViewModel)
            .previewLayout(.sizeThatFits) // กำหนดขนาดให้พอดีกับเนื้อหา
            .padding() // เพิ่ม padding เพื่อให้พรีวิวดูชัดเจนขึ้น
=======
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            Text("YOU DID IT!")
                .font(.largeTitle)
                .bold()
            
            @AppStorage("userID") var userID: String = ""
            
            Button("Next") {
                viewModel.updateLevelInDatabase(userID: userID, newLevel: viewModel.game.currentLevel)
                viewModel.showSuccessScreen = false
                viewModel.startNewLevel()
                onNext()
            }
            
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "house.fill")
                    .foregroundColor(.black)
                    .padding(10)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
>>>>>>> main
    }
}
