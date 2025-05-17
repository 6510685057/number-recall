import SwiftUI

struct RankingView: View {
    @StateObject var rankingViewModel: RankingViewModel

    init(rankingViewModel: RankingViewModel) {
        _rankingViewModel = StateObject(wrappedValue: rankingViewModel)
    }

    var body: some View {
        NavigationStack {
            VStack {
                // Header
                Text(NSLocalizedString("leaderboard", comment: ""))
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 160/255, blue: 190/255), Color(red: 255/255, green: 160/255, blue: 190/255)]), startPoint: .top, endPoint: .bottom))

                ScrollView {
                    VStack(spacing: 10) {
                        let rankings = rankingViewModel.rankings
                        ForEach(rankings.prefix(10).indices, id: \.self) { index in
                            let player = rankings[index]
                            RankingRow(
                                player: player,
                                rank: index + 1,
                                isCurrentUser: player.id == rankingViewModel.currentUserID
                            )
                        }
                    }
                    .onAppear {
                        rankingViewModel.fetchLeaderboard()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }

                Spacer()

                
                HStack {
                    Spacer()
                    NavigationLink(destination: MainView()) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(15)
                            .background(Color(red: 255/255, green: 160/255, blue: 190/255))
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct RankingRow: View {
    var player: Ranking
    var rank: Int
    var isCurrentUser: Bool = false

    var body: some View {
        HStack {
            Text("#\(rank)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(isCurrentUser ? Color.yellow : Color.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isCurrentUser ? Color(red: 50/255, green: 120/255, blue: 220/255) : Color(red: 240/255, green: 240/255, blue: 240/255))
                .cornerRadius(10)

            VStack(alignment: .leading) {
                Text(player.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isCurrentUser ? Color.yellow : Color.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }

            Spacer()

            Text("Level \(player.level)")
                .font(.subheadline)
                .foregroundColor(isCurrentUser ? Color.yellow : Color.black)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isCurrentUser ? Color(red: 50/255, green: 120/255, blue: 220/255) : Color(red: 240/255, green: 240/255, blue: 240/255))
                .cornerRadius(10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isCurrentUser ? Color(red: 100/255, green: 150/255, blue: 230/255) : Color(red: 255/255, green: 160/255, blue: 190/255))
                .shadow(radius: 10)
        )
        .padding(.vertical, 5)
        .scaleEffect(1.05)
        .animation(.easeInOut(duration: 0.3), value: isCurrentUser)
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(rankingViewModel: RankingViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
