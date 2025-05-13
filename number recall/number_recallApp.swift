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
