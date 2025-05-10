//
//  number_recallApp.swift
//  number recall
//
//  Created by Yanatthan kongkrajang on 7/5/2568 BE.
//

//import SwiftUI
//import Firebase
//
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}
//
//@main
//struct number_recallApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
//
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//        }
//    }
//}
import SwiftUI
import Firebase

@main
struct number_recallApp: App {
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
