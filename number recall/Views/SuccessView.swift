import SwiftUI

struct SuccessView: View {
    var onNext: () -> Void
    var onHome: () -> Void
    @ObservedObject var rankingViewModel: RankingViewModel
    @ObservedObject var viewModel: GameViewModel
    @Environment(\.dismiss) var dismiss
    @AppStorage("userID") var userID: String = ""

    var body: some View {
        ZStack {
            // 🌈 พื้นหลังพาสเทล
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 230/255, green: 210/255, blue: 255/255),
                    Color(red: 200/255, green: 220/255, blue: 255/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Spacer()
                
                Text(NSLocalizedString("you_did_it", comment: ""))
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .shadow(color: Color.purple.opacity(0.4), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                
                // ปุ่ม Next และ Home
                HStack(spacing: 40) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "house.fill")
                            Text(NSLocalizedString("home", comment: ""))
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(Color.purple.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(color: Color.purple.opacity(0.5), radius: 6, x: 0, y: 4)
                    }

                    Button(NSLocalizedString("next", comment: "")) {
                        viewModel.updateLevelInDatabase(userID: userID, newLevel: viewModel.game.currentLevel)
                        viewModel.showSuccessScreen = false
                        viewModel.startNewLevel()
                        onNext()
                    }
                    .font(.title3.weight(.semibold))
                    .frame(width: 150, height: 50)
                    .background(Color.pink.opacity(0.75))
                    .foregroundColor(.black)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: Color.pink.opacity(0.5), radius: 6, x: 0, y: 4)
                }
                
                Spacer()
            }
            .padding()
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
