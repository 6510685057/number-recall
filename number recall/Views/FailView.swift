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

    var body: some View {
        VStack {
            Text("SORRY, YOU LOSE")
                .font(.title)
                .bold()
            
            List(rankingViewModel.players) { player in
                HStack {
                    Text(player.name)
                    Spacer()
                    Text("Level: \(player.level)")
                        .foregroundColor(.gray)
                }
            }
            
            HStack {
                Button(action: onRetry) {
                    Image(systemName: "arrow.trianglehead.clockwise")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
                .buttonStyle(.borderedProminent)

                Button(action: onHome) {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .onAppear {
            rankingViewModel.fetchLeaderboard()
        }
    }
}
