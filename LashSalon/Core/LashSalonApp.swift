//
//  LashSalonApp.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 14.08.22.
//

import SwiftUI
import FirebaseCore
// from https://github.com/rebeloper/FirebaseService.git
import FirebaseService

// Добавляем AppDelegate как было в uikit
class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Инициализируем базу данных
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct LashSalonApp: App {
    
    // register app delegate for Firebase setup and etc...
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // Будем отслеживать состояние авторизации
    @StateObject private var authState = AuthState()
    
    var body: some Scene {
        WindowGroup {
            LogoView()
        }
    }
}
