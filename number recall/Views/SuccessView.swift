//
//  SuccessView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 9/5/2568 BE.
//

import SwiftUI

struct SuccessView: View {
    var onNext: () -> Void
    var onHome: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Text("YEAH, YOU DID IT!")
                .font(.title)
                .bold()
            Button("PLAY NEXT", action: onNext)
                .buttonStyle(.borderedProminent)
            Button(action: onHome) {
                HStack(spacing: 8) {
                    Image(systemName: "house.fill")
                        .font(.title2)
                }
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(Color.white.opacity(0.4))
                .clipShape(Capsule())
            }
        }
        .padding()
    }
}

#Preview {
    SuccessView(
        onNext: {  },
        onHome: {}
    )
}
