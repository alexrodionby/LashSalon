//
//  Session.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 19.08.22.
//

// Синглтон-сервис для сохранения данных в кейчейн
import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    static let shared = Session()
    
    // Сохраняем id тот что выдал firebase
    var token: String {
        get {
            return KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
    }
    
    // Сохраняем имя, которое ввел пользователь
    var userName: String {
        get {
            return KeychainWrapper.standard.string(forKey: "userName") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "userName")
        }
    }
    
    // Сохраняем номер телефона, который ввел пользователь
    var userPhone: String {
        get {
            return KeychainWrapper.standard.string(forKey: "userPhone") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "userPhone")
        }
    }
}
