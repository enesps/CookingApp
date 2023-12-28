//
//  KeyChainManager.swift
//  CookingApp
//
//  Created by Enes Pusa on 25.12.2023.
//

import Foundation
import KeychainAccess
class KeyChainService{
    static let shared = KeyChainService()
    
    private let keychain = Keychain(service: "com.CookingApp.CookingApp")
    
    private let tokenKey = "UserToken"

    func saveToken(_ token: String) {
        do {
            try keychain.set(token, key: tokenKey)
        } catch let error {
            print("Error saving token to Keychain: \(error)")
        }
    }
    // Token'ı silmek
    func deleteToken() {
        do {
            try keychain.remove(tokenKey)
        } catch let error {
            print("Error deleting token from Keychain: \(error)")
        }
    }
    
    // Saklanan token'ı okumak
    func readToken() -> String? {
        do {
            return try keychain.get(tokenKey)
        } catch let error {
            print("Error reading token from Keychain: \(error)")
            return nil
        }
    }
    // Token'ın nil olup olmadığını kontrol etme
     func isTokenAvailable() -> Bool {
         return readToken() != nil
     }
}
