import SwiftUI

struct RankingView: View {
    @StateObject var rankingViewModel: RankingViewModel
    
    init(rankingViewModel: RankingViewModel) {
        _rankingViewModel = StateObject(wrappedValue: rankingViewModel)
    }
    
    var body: some View {
<<<<<<< HEAD
        NavigationStack { // ใช้ NavigationStack เพื่อจัดการกับการนำทาง
            VStack {
                // หัวข้อ "Leaderboard"
                Text("Leaderboard")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 80)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
                    .cornerRadius(12)

                // รายชื่อผู้นำ
                List {
                    // เรียงลำดับผู้เล่นตามระดับจากสูงสุดไปต่ำสุด
                    ForEach(rankingViewModel.players.sorted(by: { $0.level > $1.level })) { player in
                        RankingRow(player: player, rank: rankingViewModel.players.firstIndex(where: { $0.id == player.id }) ?? 0 + 1) // ส่งลำดับที่จัดเรียงให้กับ RankingRow
                    }
                }
                .onAppear {
                    // ดึงข้อมูลผู้นำเมื่อหน้าจอโหลด
                    rankingViewModel.fetchLeaderboard()
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.orange]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        
=======
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
>>>>>>> main
        }
    }
}

struct RankingRow: View {
<<<<<<< HEAD
    var player: Player
    var rank: Int  // ลำดับที่ได้จากการเรียง

    var body: some View {
        HStack {
            // ลำดับผู้เล่น
            Text("#\(rank+1)")  // ลำดับที่คำนวณจากตัวแปร `rank`
=======
    var player: Ranking
    
    var body: some View {
        HStack {
            Text("#\(player.level)")
>>>>>>> main
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.pink.opacity(0.4))
                .cornerRadius(10)
            
<<<<<<< HEAD
            Spacer()
            
            // ชื่อผู้เล่น
            Text(player.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer()

            // ตำแหน่งระดับของผู้เล่น (Level)
=======
            VStack(alignment: .leading) {
                Text("\(player.name)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .truncationMode(.tail)
            }
            Spacer()
            
>>>>>>> main
            Text("Level \(player.level)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.pink.opacity(0.4))
                .cornerRadius(10)
        }
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.3)))
        .shadow(radius: 5)
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
