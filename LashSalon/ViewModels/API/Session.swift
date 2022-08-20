//
//  Session.swift
//  LashSalon
//
//  Created by Alexandr Rodionov on 19.08.22.
//

import Foundation
import SwiftKeychainWrapper

final class Session {
    
    private init() {}
    static let shared = Session()
    
    var token: String {
        get {
            return KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
    }
    
    var userName: String {
        get {
            return KeychainWrapper.standard.string(forKey: "userName") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "userName")
        }
    }
    
    var userPhone: String {
        get {
            return KeychainWrapper.standard.string(forKey: "userPhone") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "userPhone")
        }
    }
}
