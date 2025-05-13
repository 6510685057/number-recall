//
//  RankingView.swift
//  number recall
//
//  Created by kunakorn jindasak on 13/5/2568 BE.
//

//import SwiftUI
//
//struct RankingView: View {
//    @StateObject var rankingViewModel: RankingViewModel
//
//    init(rankingViewModel: RankingViewModel) {
//        _rankingViewModel = StateObject(wrappedValue: rankingViewModel)
//    }
//
//    var body: some View {
//        VStack {
//            // หัวข้อ "Leaderboard"
//            Text("Leaderboard")
//                .font(.system(size: 36, weight: .bold))
//                .foregroundColor(.white)
//                .padding(.top, 20)
//                .frame(maxWidth: .infinity)
//                .background(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom))
//                .cornerRadius(12)
//
//            // รายชื่อผู้นำ
//            List(rankingViewModel.players) { player in
//                RankingRow(player: player)
//            }
//            .onAppear {
//                // ดึงข้อมูลผู้นำเมื่อหน้าจอโหลด
//                rankingViewModel.fetchLeaderboard()
//            }
//            .listStyle(PlainListStyle())
//            .padding(.horizontal, 20)
//        }
//        .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .top, endPoint: .bottom))
//        .edgesIgnoringSafeArea(.all)
//    }
//}
//
//struct RankingRow: View {
//    var player: Player
//
//    var body: some View {
//        HStack {
//            // ลำดับผู้เล่น
//            Text("#\(player.level)")
//                .font(.title2)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 5)
//                .background(Color.white.opacity(0.2))
//                .cornerRadius(10)
//
//            // ชื่อผู้เล่น
//            VStack(alignment: .leading) {
//                Text("\(player.name)")
//                    .font(.title2)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .lineLimit(1)
//                    .truncationMode(.tail)
//
//            }
//            Spacer()
//
//            // ตำแหน่งระดับของผู้เล่น (Level) อยู่ขวาสุด
//            Text("Level \(player.level)")
//                .font(.subheadline)
//                .foregroundColor(.white)
//                .padding(.horizontal, 10)
//                .padding(.vertical, 5)
//                .background(Color.white.opacity(0.2))
//                .cornerRadius(10)
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 15).fill(Color.black.opacity(0.3)))
//        .shadow(radius: 10)
//        .padding(.vertical, 5)
//    }
//}
//
//struct RankingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RankingView(rankingViewModel: RankingViewModel())
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
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
    var player: Ranking  // ✅ เปลี่ยนจาก Player เป็น Ranking

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
