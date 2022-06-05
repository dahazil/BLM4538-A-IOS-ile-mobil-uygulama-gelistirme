//
//  MyCyrptoApp.swift
//  Shared
//
//  Created by Seyfettin Kılınç on 16.04.2022.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // MARK: - Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
@main
struct MyCyrptoApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            TabBarView()
            
        }
    }
}
