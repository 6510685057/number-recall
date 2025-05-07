//
//  MainView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 7/5/2568 BE.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            // พื้นหลังสีเหลือง
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Spacer()
                
                // ชื่อเกม
                Text("NUMBER RECALL")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
                
                // ปุ่มเริ่มเกม
                Text("START GAME")
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(Color.pink)
                    .foregroundColor(.black)
                    .cornerRadius(12)
                    .shadow(radius: 3)
                
                Spacer()
                
                // ไอคอนล่าง 3 อัน (Setting / Profile / Leaderboard)
                HStack(spacing: 30) {
                    
                }
                .padding(.bottom, 40)
            }
        }
    }
}


#Preview {
    MainView()
}
