import SwiftUI

struct FixedBackgroundTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(Color.white)
            .foregroundColor(.black) 
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}


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
        return Color.gray.opacity(0.3)
    }

    var body: some View {
        ZStack {
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
                    .foregroundColor(Color.black)
                    .padding(.top, 30)

                ZStack {
                    Circle()
                        .fill(backgroundColor(for: selectedIcon))
                        .frame(width: 120, height: 120)
                        .shadow(color: Color.white.opacity(0.4), radius: 6, x: 0, y: 4)

                    Image(systemName: selectedIcon.isEmpty ? "person.crop.circle.fill" : selectedIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color.white)
                }

                VStack(spacing: 20) {

                    
                    TextField(NSLocalizedString("enter_name", comment: ""), text: $name)
                        .textFieldStyle(FixedBackgroundTextFieldStyle())
                        .padding(.horizontal)

                        

                    Text(NSLocalizedString("choose_icon", comment: ""))
                        .font(.headline)
                        .foregroundColor(Color.black)

                    
                    LazyVGrid(columns: [GridItem(), GridItem(), GridItem()], spacing: 20) {
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .padding()
                                .background(backgroundColor(for: icon))
                                .cornerRadius(12)
                                .foregroundColor(.white)
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

                    
                    Button(NSLocalizedString("ok", comment: "")) {
                        viewModel.updateUserProfile(id: userID, name: name, icon: selectedIcon)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green.opacity(0.8))
                    .foregroundColor(Color.white)
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
        .preferredColorScheme(.light)  
    }
}

#Preview {
    ProfileView()
}
