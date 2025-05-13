import SwiftUI

struct SuccessView: View {
    var onNext: () -> Void
    var onHome: () -> Void
    @ObservedObject var rankingViewModel: RankingViewModel
    @ObservedObject var viewModel: GameViewModel  // เพิ่มตัวแปรนี้
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack {
            Text("YOU DID IT!")
                .font(.largeTitle)
                .bold()
            
            @AppStorage("userID") var userID: String = ""
            
            Button("Next") {
                viewModel.updateLevelInDatabase(userID: userID, newLevel: viewModel.game.currentLevel)
                viewModel.showSuccessScreen = false
                viewModel.startNewLevel()
                onNext()
            }
            
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "house.fill")
                    .foregroundColor(.black)
                    .padding(10)
            }
        }
        .padding()
        .navigationBarBackButtonHidden(true)
    }
}
