import SwiftUI

struct RankingView: View {
    @StateObject var rankingViewModel: RankingViewModel
    
    init(rankingViewModel: RankingViewModel) {
        _rankingViewModel = StateObject(wrappedValue: rankingViewModel)
    }
    
    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 20)
                .frame(maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
                .cornerRadius(12)
            
            let rankings = rankingViewModel.rankings
            List(rankings.prefix(10)) { player in
                RankingRow(player: player)
            }
            .onAppear {
                rankingViewModel.fetchLeaderboard()
            }
            .listStyle(PlainListStyle())
            .padding(.horizontal, 20)
        }
        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
    }
}

struct RankingRow: View {
    var player: Ranking
    
    var body: some View {
        HStack {
            Text("#\(player.level)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("\(player.name)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            
            Text("Level \(player.level)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.3)))
        .shadow(radius: 10)
        .padding(.vertical, 5)
        
    }
    
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView(rankingViewModel: RankingViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
