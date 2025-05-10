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
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {  // เพิ่ม NavigationView รอบๆ เนื้อหาทั้งหมด
            ZStack {
                Color(red: 255/255, green: 218/255, blue: 107/255)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    Text("NUMBER RECALL")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.black)
                    

                    HStack {
                        NavigationLink(destination: LoginView()) {
                            Text("START GAME")
                                .font(.title2)
                                .padding()
                                .frame(width: 200)
                                .background(Color(red: 255/255, green: 177/255, blue: 239/255))
                                .foregroundColor(.black)
                                .cornerRadius(12)
                                .shadow(radius: 3)
                        }
                        
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 30) {
                        NavigationLink(destination: SettingView()) {
                            Image(systemName: "gearshape.fill").iconStyle()
                        }
                        Image(systemName: "flag.pattern.checkered.2.crossed").iconStyle()
                        Image(systemName: "person.crop.circle.fill").iconStyle()
                        
                    }
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

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
