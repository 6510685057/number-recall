//import SwiftUI
//
//struct SettingView: View {
//    @AppStorage("language") var language: String = "ENG"
//    @Environment(\.dismiss) var dismiss
//    
//    var body: some View {
//        ZStack {
//            Color(red: 255/255, green: 218/255, blue: 104/255)
//                .edgesIgnoringSafeArea(.all)
//            
//            
//            VStack(spacing: 25) {
//                HStack {
//                    Button(action: {
//                        dismiss()
//                    }){
//                        Image(systemName: "house.fill")
//                            .foregroundColor(.black)
//                            .font(.title2)
//                            .padding(10)
//                            .background(Color.white.opacity(0.4))
//                            .clipShape(Circle())
//                    }
//                    Spacer()
//                }
//                .padding(.top, 60)
//                .padding(.horizontal, 30)
//                HStack {
//                    Spacer()
//                    Text("SETTING")
//                        .font(.system(size: 40, weight: .bold))
//                        .foregroundColor(.black)
//                        .padding(.top, 60)
//                    Spacer()
//                }
//                
//                HStack {
//                    Spacer()
//                    Text("CHOOSE LANGUAGE")
//                        .font(.system(size: 30))
//                        .foregroundColor(.black)
//                        .padding(.trailing, 50)
//                }
//                
//                VStack(spacing: 20) {
//                    LanguageOption(title: "THAI", selected: language == "TH") {
//                        language = "TH"
//                    }
//                    
//                    LanguageOption(title: "ENGLISH", selected: language == "ENG") {
//                        language = "ENG"
//                    }
//                }
//                .padding(.horizontal, 40)
//                
//                Spacer()
//            }
//        }
//    }
//}
//
//struct LanguageOption: View {
//    let title: String
//    let selected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        HStack {
//            Circle()
//                .fill(selected ? .black : .white)
//                .frame(width: 18, height: 18)
//                .overlay(Circle().stroke(Color.black, lineWidth: 1.5))
//            Text(title)
//                .foregroundColor(.black)
//                .font(.system(size: 22))
//                .padding(.leading, 10)
//            Spacer()
//        }
//        .padding()
//        .background(Color.white.opacity(0.3))
//        .cornerRadius(12)
//        .onTapGesture {
//            action()
//        }
//    }
//}
//
//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SettingView()
//        }
//    }
//}
//
import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showSettingsAlert = false
    @State private var showReturnButton = false

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 218/255, blue: 104/255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 25) {
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "house.fill")
                            .foregroundColor(.black)
                            .font(.title2)
                            .padding(10)
                            .background(Color.white.opacity(0.4))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.top, 60)
                .padding(.horizontal, 30)

                Spacer()

                Text("Change Language")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.black)

                Button(action: {
                    showSettingsAlert = true
                }) {
                    Text("Go to iPhone Settings")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                if showReturnButton {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Return to Game")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }

                Spacer()
            }
            .padding()
            .alert("Change language in iPhone settings", isPresented: $showSettingsAlert) {
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString),
                       UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                        showReturnButton = true
                    }
                }
                Button("Cancel", role: .cancel) {
                    showSettingsAlert = false
                }
            } message: {
                Text("To change the language, go to iPhone Settings > [Your App] > Language.")
            }
        }
    }
}
