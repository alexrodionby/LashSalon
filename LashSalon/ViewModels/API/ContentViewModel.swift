//
//  ContentViewModel.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 19.08.22.
//

// Расширение для вью, чтобы реализовать логаут из учетки эпл
import SwiftUI
import Combine
import FirebaseService

extension SettingsView {
    
    class ViewModel: ObservableObject {
        
        var cancellables: Set<AnyCancellable> = []
        
        func logout() async throws {
            let promise = AuthService.logout()
            try await AsyncPromise.fulfiil(promise, storedIn: &cancellables)
            Session.shared.token = ""
            Session.shared.userName = ""
            Session.shared.userPhone = ""
            print("Наш токен =", Session.shared.token)
            print("Наше имя =", Session.shared.userName)
            print("Наш телефон =", Session.shared.userPhone)
        }
    }
}
