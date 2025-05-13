//
//  FailView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.
//

import SwiftUI

struct FailView: View {
    var onRetry: () -> Void
    var onHome: () -> Void
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var rankingViewModel: RankingViewModel
    @State private var isRetryActive = false  // สถานะการ navigate ไปที่หน้าเกมใหม่
    @State private var isHomeActive = false   // สถานะการ navigate กลับไปหน้า Home

    var body: some View {
        NavigationStack { // ใช้ NavigationStack สำหรับการนำทาง
            VStack {
                Text("SORRY, YOU LOSE")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                // รายชื่อผู้นำ
                List {
                    // เรียงลำดับผู้เล่นตามระดับจากสูงสุดไปต่ำสุด
                    ForEach(rankingViewModel.players.sorted(by: { $0.level > $1.level })) { player in
                        let rank = rankingViewModel.players.firstIndex(where: { $0.id == player.id }) ?? 0 + 1
                        RankingRow(player: player, rank: rank)
                    }
                }

                Spacer()
                
                // ปุ่ม Retry และ Home
                HStack {
                    Button(action: {
                        // เมื่อคลิก Retry ให้กลับไปที่ด่านที่เล่นล่าสุด
                        viewModel.game.currentLevel = viewModel.game.currentLevel
                        viewModel.startNewLevel()  // เริ่มด่านเดิม
                        isRetryActive = true  // เรียก NavigationLink ไปยังหน้าเกมใหม่
                    }) {
                        Image(systemName: "arrow.trianglehead.clockwise")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink.opacity(0.6))
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())

                    Button(action: {
                        // เมื่อคลิก Home ให้กลับไปที่หน้า MainView
                        isHomeActive = true  // เรียก NavigationLink กลับไปหน้า Home
                    }) {
                        Image(systemName: "house.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.pink.opacity(0.6))
                            .cornerRadius(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top, 20)
                
                // NavigationLink สำหรับ Retry
                NavigationLink(value: "Retry") {
                    EmptyView()
                }
                .navigationDestination(isPresented: $isRetryActive) {
                    GameView()  // หน้าจอเกม
                }
                
                // NavigationLink สำหรับ Home
                NavigationLink(value: "Home") {
                    EmptyView()
                }
                .navigationDestination(isPresented: $isHomeActive) {
                    MainView()  // หน้าหลัก
                }
            }
            .onAppear {
                rankingViewModel.fetchLeaderboard()  // ดึงข้อมูลผู้เล่น
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.pink, Color.purple]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Ranking: View {
    var player: Player
    var rank: Int

    var body: some View {
        HStack {
            Text("#\(rank+1)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.pink.opacity(0.4))
                .cornerRadius(10)
            
            Spacer()
            
            Text(player.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Spacer()

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

struct FailView_Previews: PreviewProvider {
    static var previews: some View {
        let mockRankingViewModel = RankingViewModel()
        
        mockRankingViewModel.players = [
            Player(id: "1", name: "Player 1", level: 5),
            Player(id: "2", name: "Player 2", level: 3),
            Player(id: "3", name: "Player 3", level: 7)
        ]
        
        return FailView(onRetry: {
            print("Retry tapped")
        }, onHome: {
            print("Home tapped")
        }, viewModel: GameViewModel(), rankingViewModel: mockRankingViewModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
