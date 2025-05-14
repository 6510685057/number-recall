import SwiftUI

struct FailView: View {
    var onRetry: () -> Void
    var onHome: () -> Void
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var rankingViewModel: RankingViewModel
    
    var body: some View {
        ZStack {
            // 🌞 พื้นหลังโทนสีร้อน (สีส้ม-แดง)
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 255/255, green: 180/255, blue: 100/255),  // ส้มอ่อน
                    Color(red: 255/255, green: 80/255, blue: 50/255)     // แดง
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .opacity(0.8)
            .ignoresSafeArea()
            
            VStack {
                Text("SORRY, YOU LOSE")
                    .font(.title)
                    .bold()
                    .shadow(radius: 5)
                    .foregroundColor(.white)
                    .padding(.top, 40)
                
                // รายการคะแนน
                List(rankingViewModel.rankings.indices, id: \.self) { index in
                    let player = rankingViewModel.rankings[index]
                    HStack {
                        // แสดงลำดับ
                        Text("#\(index + 1)") // ลำดับผู้เล่นเริ่มจาก 1
                            .font(.title3)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.red.opacity(0.6))
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
                            .background(Color.white.opacity(0.6))
                            .cornerRadius(10)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white.opacity(0.6))
                            .shadow(radius: 5)
                    )
                    .padding(.vertical, 5)
                }
                
                // ปุ่ม Retry และ Home
                HStack(spacing: 30) {
                    // ปุ่ม Retry (จะไม่ใช้ NavigationLink)
                    Button(action: {
                        onRetry()
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath") // ไอคอนรีเทิร์น
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.orange.opacity(0.8))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    
                    // ปุ่ม Home ใช้ NavigationLink
                    NavigationLink(destination: MainView()) {
                        Image(systemName: "house.fill") // ไอคอนโฮม
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(15)
                            .background(Color.red.opacity(0.8))
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
                // เมื่อกด Retry ให้กลับไปที่ด่านเลเวลหนึ่ง
                print("Retry clicked: Go to level 1")
            }, onHome: {
                // เมื่อกด Home ให้กลับไปที่หน้าเมนูหลัก
                print("Home clicked: Go to main menu")
            }, viewModel: GameViewModel(), rankingViewModel: RankingViewModel())
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}
