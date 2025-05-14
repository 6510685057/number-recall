import SwiftUI

struct ProfileView: View {
    @AppStorage("userID") var userID: String = ""
    @StateObject var viewModel = LoginViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    
    @State private var name: String = ""
    @State private var selectedIcon: String = ""
    
    
    let icons = ["star.fill", "flame.fill", "pawprint.fill", "teddybear.fill", "dog.fill", "cloud.fill"]
    let iconColors: [Color] = [.red, .green, .blue, .pink, .purple, .orange]
    
    // ฟังก์ชันหาสีตาม icon ที่เลือก
    func backgroundColor(for icon: String) -> Color {
        if let index = icons.firstIndex(of: icon) {
            return iconColors[index]
        }
        return .gray
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text(NSLocalizedString("your profile", comment: ""))
                .font(.largeTitle)
                .padding(.top, 30)
            
            // แสดง icon ผู้เล่นพร้อมพื้นหลังสี
            Image(systemName: selectedIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding()
                .background(backgroundColor(for: selectedIcon))
                .clipShape(Circle())
            
            // ชื่อผู้เล่น
            TextField(NSLocalizedString("enter_name", comment: ""), text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Text(NSLocalizedString("choose_icon", comment: ""))
                .font(.headline)

            
            
            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
                ForEach(icons, id: \.self) { icon in
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                        .background(backgroundColor(for: icon))
                        .cornerRadius(8)
                        .onTapGesture {
                            selectedIcon = icon
                        }
                }
            }
            .padding()
            
            Button(NSLocalizedString("ok", comment: "")){
                viewModel.updateUserProfile(id: userID, name: name, icon: selectedIcon)
                presentationMode.wrappedValue.dismiss()
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
