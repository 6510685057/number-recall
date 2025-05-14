import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @StateObject var gameViewModel = GameViewModel()
    
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var selectedIconIndex: Int? = nil
    @State private var selectedIconColor: Color = .clear
    @State private var isActive: Bool = false
    @AppStorage("userID") var userID: String = ""
    
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
            // 🌈 พื้นหลังไล่สีพาสเทล
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 180/255, green: 230/255, blue: 255/255),
                    Color(red: 255/255, green: 250/255, blue: 200/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                // ปุ่มกลับบ้าน
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
                
                // 🧸 ไอคอนให้เลือก
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
                .padding(.top, 20)
                
                // ไอคอนที่เลือก
                VStack {
                    if let index = selectedIconIndex {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(iconColors[index].opacity(0.6))
                                .frame(width: 100, height: 100)
                                .shadow(color: .white.opacity(0.4), radius: 4, x: 0, y: 2)
                            
                            Image(systemName: icons[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                // ❌ ไม่กำหนด .foregroundColor ให้ไอคอนใช้สี default
                        }
                    } else {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 100, height: 100)
                    }
                }
                
                // กรอกชื่อ
                VStack(alignment: .leading, spacing: 10) {
                    Text("NAME")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    TextField("Enter your name", text: $name)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                }
                .padding(.horizontal, 40)
                
                // กรอกอายุ
                VStack(alignment: .leading, spacing: 10) {
                    Text("AGE")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    TextField("Enter your age", text: $age)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(12)
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3), lineWidth: 1))
                }
                .padding(.horizontal, 40)
                
                // ปุ่ม OK
                Button(action: {
                    userID = name
                    viewModel.saveUser(id: userID, name: name, age: age, icon: icons[selectedIconIndex ?? 0])
                    isActive = true
                }) {
                    Text("OK")
                        .font(.title3)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 12)
                        .background(Color.pink.opacity(0.6))
                        .foregroundColor(.black)
                        .cornerRadius(14)
                        .shadow(color: .pink.opacity(0.3), radius: 5, x: 0, y: 2)
                }
                .navigationDestination(isPresented: $isActive) {
                    GameView()
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
    
    // ฟังก์ชันสร้างปุ่มเลือกไอคอน
    func iconButton(index: Int) -> some View {
        Image(systemName: icons[index])
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .padding(14)
            .background(iconColors[index].opacity(0.6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(selectedIconIndex == index ? Color.black.opacity(0.6) : Color.clear, lineWidth: 2)
            )
            .shadow(color: .white.opacity(0.3), radius: 3, x: 0, y: 2)
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
