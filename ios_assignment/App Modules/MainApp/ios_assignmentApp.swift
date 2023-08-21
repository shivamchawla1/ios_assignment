//
//  ios_assignmentApp.swift
//  ios_assignment
//
//  Created by Shivam Chawla on 21/08/23.
//

import SwiftUI
import Firebase

@main
struct ios_assignmentApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            let viewModel = AppViewModel()
            AuthView()
                .environmentObject(viewModel)
        }
    }
}
class AppDelegate : NSObject , UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}
