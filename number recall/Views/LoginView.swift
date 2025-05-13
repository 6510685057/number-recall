import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()// เชื่อมโยงกับ ViewModel
    @StateObject var gameViewModel = GameViewModel()
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var selectedIconIndex: Int? = nil
    @State private var selectedIconColor: Color = .clear
    @State private var isActive: Bool = false  // ใช้เพื่อควบคุม NavigationLink
    @AppStorage("userID") var userID: String = ""
    @State private var selectedIcon: String = ""


    let icons = [
        "star.fill", "flame.fill", "dog.fill",
        "pawprint.fill", "teddybear.fill", "cloud.fill"
    ]

    let iconColors: [Color] = [
        .red, .green, .blue,
        .pink, .purple, .orange
    ]

    init() {
        let randomIndex = Int.random(in: 0..<6)
        _selectedIconIndex = State(initialValue: randomIndex)
        _selectedIconColor = State(initialValue: iconColors[randomIndex])
    }

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 218/255, blue: 104/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 25) {
                HStack {
                    NavigationLink(destination: MainView()) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.top, 30)
                .padding(.horizontal, 30)

                Text("NUMBER RECALL")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)

                // การเลือกไอคอน
                VStack(spacing: 12) {
                    HStack(spacing: 20) {
                        ForEach(0..<3, id: \.self) { index in
                            iconButton(index: index)
                        }
                    }
                    HStack(spacing: 20) {
                        ForEach(3..<6, id: \.self) { index in
                            iconButton(index: index)
                        }
                    }
                }
                .padding(.top, 30)

                VStack {
                    if let index = selectedIconIndex {
                        Image(systemName: icons[index])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.black)
                            .padding()
                            .background(selectedIconColor)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 100, height: 100)
                    } else {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 100, height: 100)
                    }
                }

                VStack(alignment: .leading, spacing: 10) {
                    Text("NAME")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40)
                        .padding(.trailing)
                }
                .padding(.horizontal, 40)

                VStack(alignment: .leading, spacing: 10) {
                    Text("AGE")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    TextField("Enter your age", text: $age)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(height: 40)
                        .padding(.trailing)
                }
                .padding(.horizontal, 40)

//                @AppStorage("userID") var userID: String = ""
                
                Button(action: {
                    userID = name
                    viewModel.saveUser(id: userID, name: name, age: age, icon: icons[selectedIconIndex ?? 0])
                    isActive = true
                }) {
                    Text("OK")
                        .font(.title3)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 10)
                        .background(Color(red: 255/255, green: 177/255, blue: 239/255))
                        .foregroundColor(.black)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                }

                NavigationLink(destination: GameView(), isActive: $isActive) {
                    EmptyView()
                }

                Spacer()
            }
            
            .onAppear {
                if !userID.isEmpty {
                    viewModel.fetchUserLevel(id: userID) { level in
                        if let level = level {
                            gameViewModel.maxLevel = level
                        }
                        isActive = true
                    }
                }
            }

        }
        
    }

    func iconButton(index: Int) -> some View {
        Image(systemName: icons[index])
            .resizable()
            .scaledToFit()
            .frame(width: 55, height: 55)
            .padding()
            .background(iconColors[index])
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(selectedIconIndex == index ? Color.black : Color.clear, lineWidth: 3)
            )
            .onTapGesture {
                selectedIconIndex = index
                selectedIconColor = iconColors[index]
            }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LoginView()
        }
    }
}
