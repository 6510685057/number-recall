//
//  SettingView.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 7/5/2568 BE.
//

import SwiftUI

struct SettingView: View {
    @AppStorage("language") var language: String = "ENG"

    var body: some View {
        ZStack {
            Color(red: 255/255, green: 218/255, blue: 104/255)
                .edgesIgnoringSafeArea(.all)
            

            VStack(spacing: 25) {
                HStack {
                                    Button(action: {
                                    
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
                HStack {
                    Spacer()
                    Text("SETTING")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.black)
                        .padding(.top, 60)
                    Spacer()
                }

                HStack {
                    Spacer()
                    Text("CHOOSE LANGUAGE")
                        .font(.system(size: 30))
                        .foregroundColor(.black)
                        .padding(.trailing, 50)
                }

                VStack(spacing: 20) {
                    LanguageOption(title: "THAI", selected: language == "TH") {
                        language = "TH"
                    }

                    LanguageOption(title: "ENGLISH", selected: language == "ENG") {
                        language = "ENG"
                    }
                }
                .padding(.horizontal, 40)

                Spacer()
            }
        }
    }
}

struct LanguageOption: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        HStack {
            Circle()
                .fill(selected ? .black : .white)
                .frame(width: 18, height: 18)
                .overlay(Circle().stroke(Color.black, lineWidth: 1.5))
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 22))
                .padding(.leading, 10)
            Spacer()
        }
        .padding()
        .background(Color.white.opacity(0.3))
        .cornerRadius(12)
        .onTapGesture {
            action()
        }
    }
}

#Preview {
    SettingView()
}
