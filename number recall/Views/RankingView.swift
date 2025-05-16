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
                    .background(LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.6), .pink.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
                
                // List of players with their rankings
                ScrollView {
                    VStack(spacing: 10) {
                        let rankings = rankingViewModel.rankings
                        ForEach(rankings.prefix(10).indices, id: \.self) { index in
                            let player = rankings[index]
                            RankingRow(
                                player: player,
                                rank: index + 1,
                                isCurrentUser: player.id == rankingViewModel.currentUserID  // เปรียบเทียบกับ uid ของ user ปัจจุบัน
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
                
                // NavigationLink for Home Button
                HStack {
                    Spacer()
                    NavigationLink(destination: MainView()) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .padding(15)
                            .background(Color.pink.opacity(0.6))
                            .clipShape(Circle())
                            .shadow(radius: 10)
                    }
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)  // ซ่อนปุ่ม back
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
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(isCurrentUser ? .yellow : .white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isCurrentUser ? Color.blue.opacity(0.8) : Color.white.opacity(0.3))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(player.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(isCurrentUser ? .yellow : .white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            
            Spacer()
            
            Text("Level \(player.level)")
                .font(.subheadline)
                .foregroundColor(isCurrentUser ? .yellow : .white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(isCurrentUser ? Color.blue.opacity(0.8) : Color.white.opacity(0.3))
                .cornerRadius(10)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(isCurrentUser ? Color.blue.opacity(0.6) : Color.pink.opacity(0.3))
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
