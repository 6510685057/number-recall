import SwiftUI

struct ProfileView: View {
    @AppStorage("userID") var userID: String = ""
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State private var name: String = ""
    @State private var selectedIcon: String = ""

    let icons = ["star.fill", "flame.fill", "pawprint.fill", "teddybear.fill", "dog.fill", "cloud.fill"]
    let iconColors: [Color] = [.red, .green, .blue, .pink, .purple, .orange]

    func backgroundColor(for icon: String) -> Color {
        if let index = icons.firstIndex(of: icon) {
            return iconColors[index].opacity(0.6)
        }
        return .gray.opacity(0.3)
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
                Text(NSLocalizedString("your profile", comment: ""))
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.top, 30)

                // 🧸 รูปโปรไฟล์
                ZStack {
                    Circle()
                        .fill(backgroundColor(for: selectedIcon))
                        .frame(width: 120, height: 120)
                        .shadow(color: .white.opacity(0.4), radius: 6, x: 0, y: 4)

                    Image(systemName: selectedIcon.isEmpty ? "person.crop.circle.fill" : selectedIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                }

                VStack(spacing: 20) {

                    // ชื่อผู้เล่น
                    TextField(NSLocalizedString("enter_name", comment: ""), text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Text(NSLocalizedString("choose_icon", comment: ""))
                        .font(.headline)

                    // 🧩 Grid เลือก icon
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(backgroundColor(for: icon))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(icon == selectedIcon ? Color.black : Color.clear, lineWidth: 2)
                                )
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.horizontal)

                    // 💾 ปุ่ม Save
                    Button(NSLocalizedString("ok", comment: "")) {
                        viewModel.updateUserProfile(id: userID, name: name, icon: selectedIcon)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .padding(.horizontal, 30)

                    Spacer()
                }
                .padding()
            }
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

#Preview {
    ProfileView()
}
