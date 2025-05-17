import SwiftUI

struct FailView: View {
    var onRetry: () -> Void
    var onHome: () -> Void
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var rankingViewModel: RankingViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 255/255, green: 180/255, blue: 100/255),
                    Color(red: 255/255, green: 80/255, blue: 50/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        
            VStack {
                Text(NSLocalizedString("sorry_you_lose", comment: ""))
                    .font(.title)
                    .bold()
                    .shadow(radius: 5)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // รายการคะแนน
                List(rankingViewModel.rankings.indices, id: \.self) { index in
                    let player = rankingViewModel.rankings[index]
                    HStack {
                        Text("#\(index + 1)")
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(red: 255/255, green: 0/255, blue: 0/255, opacity: 0.6))
                            .cornerRadius(10)

                        Text(player.name)
                            .font(.title3)
                            .foregroundColor(.black)

                        Spacer()

                        Text("Level: \(player.level)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.6))
                            .cornerRadius(10)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 255/255, green: 255/255, blue: 255/255, opacity: 0.6))
                            .shadow(radius: 5)
                    )
                    .padding(.vertical, 5)
                }

                // ปุ่ม Retry และ Home
                HStack(spacing: 15) {
                    Button(action: {
                        onRetry()
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color(red: 255/255, green: 140/255, blue: 0/255, opacity: 0.8))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }

                    Button(action: {
                        onHome()
                    }) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color(red: 255/255, green: 0/255, blue: 0/255, opacity: 0.8)) 
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding(20)
            }
        }
        .onAppear {
            rankingViewModel.fetchLeaderboard()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FailView(onRetry: {
                print("Retry clicked: Go to level 1")
            }, onHome: {
                print("Home clicked: Go to main menu")
            }, viewModel: GameViewModel(), rankingViewModel: RankingViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
