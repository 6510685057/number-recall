import SwiftUI

struct MainView: View {
    @AppStorage("userID") var userID: String = ""
    @State private var startGame = false
    @State private var showSettingsAlert = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 255/255, green: 218/255, blue: 107/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    Text("NUMBER RECALL")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)
                    
                    // ปุ่ม START GAME
                    Button(NSLocalizedString("start_game", comment: "")) {
                        startGame = true
                    }
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color(red: 255/255, green: 177/255, blue: 239/255))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                    
                    
                    NavigationLink(
                        destination: userID.isEmpty
                        ? AnyView(LoginView())
                        : AnyView(GameView(
                            viewModel: GameViewModel(),
                            rankingViewModel: RankingViewModel())),
                        isActive: $startGame
                    ) {
                        EmptyView()
                    }
                    
                    Spacer()
                    
                    
                    HStack(spacing: 30) {
                        Button(action: {
                            showSettingsAlert = true
                        }) {
                            Image(systemName: "gearshape.fill").iconStyle()
                        }

                        
                        NavigationLink(destination: RankingView(rankingViewModel: RankingViewModel())) {
                            Image(systemName: "flag.pattern.checkered.2.crossed").iconStyle()
                        }
                        
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.crop.circle.fill").iconStyle()
                        }
                    }
                    .padding(.bottom, 40)
                    .navigationBarBackButtonHidden(true)
                }
            }
            .alert("Change language in iPhone settings", isPresented: $showSettingsAlert) {
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                    }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("To change the language, go to iPhone Settings > number recall > Language.")
            }
        }
    }
}


extension Image {
    func iconStyle() -> some View {
        self
            .resizable()
            .frame(width: 36, height: 36)
            .foregroundColor(.black)
            .padding(10)
            .background(Color(red: 230/255, green: 169/255, blue: 255/255))
            .cornerRadius(12)
    }
}

#Preview {
    MainView()
}
