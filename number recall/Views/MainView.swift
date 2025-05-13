//
//  MainView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 7/5/2568 BE.
//

//import SwiftUI
//
//struct MainView: View {
//    var body: some View {
//        ZStack {
//            Color(red: 255/255, green: 218/255, blue: 107/255)
//                .edgesIgnoringSafeArea(.all)
//            
//            VStack(spacing: 40) {
//                Spacer()
//                
//                Text("NUMBER RECALL")
//                    .font(.system(size: 36, weight: .bold))
//                    .foregroundColor(.black)
//                
//
//                HStack {
//                    NavigationLink(destination: LoginView()) {
//                        Text("START GAME")
//                            .font(.title2)
//                            .padding()
//                            .frame(width: 200)
//                            .background(Color(red: 255/255, green: 177/255, blue: 239/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(12)
//                            .shadow(radius: 3)
//                    }
//                    
//                }
//                
//                Spacer()
//                
//                HStack(spacing: 30) {
//                    NavigationLink(destination: SettingView()) {
//                        Image(systemName: "gearshape.fill").iconStyle()
//                    }
//                    Image(systemName: "flag.pattern.checkered.2.crossed").iconStyle()
//                    Image(systemName: "person.crop.circle.fill").iconStyle()
//                    
//                }
//                .padding(.bottom, 40)
//            }
//        }
//    }
//}
//extension Image {
//    func iconStyle() -> some View {
//        self
//            .resizable()
//            .frame(width: 36, height: 36)
//            .foregroundColor(.black)
//            .padding(10)
//            .background(Color(red: 230/255, green: 169/255, blue: 255/255))
//            .cornerRadius(12)
//            
//    }
//}
//
//
//#Preview {
//    MainView()
//}

//import SwiftUI
//
//struct MainView: View {
//    var body: some View {
//        NavigationStack {  // ใช้ NavigationStack เพื่อครอบทุกหน้า
//            ZStack {
//                Color(red: 255/255, green: 218/255, blue: 107/255)
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack(spacing: 40) {
//                    Spacer()
//                    
//                    Text("NUMBER RECALL")
//                        .font(.system(size: 36, weight: .bold))
//                        .foregroundColor(.black)
//                    
//                    // ปุ่ม Start Game ที่เชื่อมไปหน้า LoginView
//                    NavigationLink(destination: LoginView()) {
//                        Text("START GAME")
//                            .font(.title2)
//                            .padding()
//                            .frame(width: 200)
//                            .background(Color(red: 255/255, green: 177/255, blue: 239/255))
//                            .foregroundColor(.black)
//                            .cornerRadius(12)
//                            .shadow(radius: 3)
//                    }
//                    
//                    Spacer()
//                    
//                    // ตัวเลือก Icon ต่างๆ ที่ใช้ NavigationLink
//                    HStack(spacing: 30) {
//                        NavigationLink(destination: SettingView()) {
//                            Image(systemName: "gearshape.fill").iconStyle()
//                        }
//                        
//                        NavigationLink(destination: RankingView(rankingViewModel: RankingViewModel())) {
//                            Image(systemName: "flag.pattern.checkered.2.crossed").iconStyle()
//                        }
//
//
//                        NavigationLink(destination: ProfileView()) {
//                            Image(systemName: "person.crop.circle.fill").iconStyle()
//                        }
//
//                    }
//                    .padding(.bottom, 40)
//                }
//            }
//        }
//    }
//}
//
//extension Image {
//    func iconStyle() -> some View {
//        self
//            .resizable()
//            .frame(width: 36, height: 36)
//            .foregroundColor(.black)
//            .padding(10)
//            .background(Color(red: 230/255, green: 169/255, blue: 255/255))
//            .cornerRadius(12)
//    }
//}
//
//#Preview {
//    MainView()
//}
import SwiftUI

struct MainView: View {
    @AppStorage("userID") var userID: String = ""
    @State private var startGame = false
    

    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 255/255, green: 218/255, blue: 107/255)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 40) {
                    Spacer()

                    Text("NUMBER RECALL")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)

                    // ปุ่ม START GAME
                    Button("START GAME") {
                        startGame = true
                    }
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color(red: 255/255, green: 177/255, blue: 239/255))
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(radius: 3)

                    // NavigationLink แบบซ่อนตัว
                    NavigationLink(
                        destination: userID.isEmpty
                            ? AnyView(LoginView())
                            : AnyView(GameView(
                                viewModel: GameViewModel(),
                                rankingViewModel: RankingViewModel())),
                        isActive: $startGame
                    ) {
                        EmptyView()
                    }

                    Spacer()

                    // เมนูไอคอนอื่น ๆ
                    HStack(spacing: 30) {
                        NavigationLink(destination: SettingView()) {
                            Image(systemName: "gearshape.fill").iconStyle()
                        }

                        NavigationLink(destination: RankingView(rankingViewModel: RankingViewModel())) {
                            Image(systemName: "flag.pattern.checkered.2.crossed").iconStyle()
                        }

                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.crop.circle.fill").iconStyle()
                        }
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// Styling สำหรับไอคอน
extension Image {
    func iconStyle() -> some View {
        self
            .resizable()
            .frame(width: 36, height: 36)
            .foregroundColor(.black)
            .padding(10)
            .background(Color(red: 230/255, green: 169/255, blue: 255/255))
            .cornerRadius(12)
    }
}

#Preview {
    MainView()
}
