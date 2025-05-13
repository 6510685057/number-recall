//
//  ProfileView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 14/5/2568 BE.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("userID") var userID: String = ""
    @StateObject var viewModel = LoginViewModel()

    @State private var name: String = ""
    @State private var selectedIcon: String = "star.fill"

    let icons = ["star.fill", "flame.fill", "pawprint.fill", "teddybear.fill", "dog.fill", "cloud.fill"]
    let iconColors: [Color] = [.red, .green, .blue, .pink, .purple, .orange]


    var body: some View {
        VStack(spacing: 20) {
            Text("Your Profile")
                .font(.largeTitle)
                .padding(.top, 30)

            Image(systemName: selectedIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
                .background(Color.yellow.opacity(0.3))
                .clipShape(Circle())

            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Text("Choose Your Icon").font(.headline)

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(icons, id: \.self) { icon in
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(selectedIcon == icon ? Color.blue.opacity(0.4) : Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedIcon = icon
                        }
                }
            }
            .padding()

            Button("Save") {
                viewModel.updateUserProfile(id: userID, name: name, icon: selectedIcon)
            }
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)

            Spacer()
        }
        .onAppear {
            viewModel.fetchUserProfile(id: userID) { profile in
                if let profile = profile {
                    self.name = profile.name
                    self.selectedIcon = profile.icon
                }
            }
        }
    }
}

