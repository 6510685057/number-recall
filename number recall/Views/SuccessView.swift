import SwiftUI

struct SuccessView: View {
    var onNext: () -> Void
    var onHome: () -> Void
    @ObservedObject var rankingViewModel: RankingViewModel
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    @AppStorage("userID") var userID: String = ""  // ✅ ย้ายออกจาก body

    var body: some View {
        ZStack {
            // 🌈 พื้นหลังพาสเทล
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 230/255, green: 210/255, blue: 255/255),  // ลาเวนเดอร์
                    Color(red: 200/255, green: 220/255, blue: 255/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text(NSLocalizedString("you_did_it", comment: ""))
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)

                // ✅ ปุ่ม Next และ Home ข้างกัน
                HStack(spacing: 30) {
                    // ปุ่ม Home
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 150, height: 50)
                            .background(Color.purple.opacity(0.6))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 5)
                    }

                    // ปุ่ม Next
                    Button(NSLocalizedString("next", comment: "")) {
                        viewModel.updateLevelInDatabase(userID: userID, newLevel: viewModel.game.currentLevel)
                        viewModel.showSuccessScreen = false
                        viewModel.startNewLevel()
                        onNext()
                    }
                    .font(.title3)
                    .padding()
                    .frame(width: 150, height: 50)
                    .background(Color.pink.opacity(0.6))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SuccessView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessView(
            onNext: {},
            onHome: {},
            rankingViewModel: RankingViewModel(),
            viewModel: GameViewModel()
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
