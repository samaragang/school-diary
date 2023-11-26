//
//  AccountModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

final class Account {
    fileprivate let emailKey = "userDefaults.email"
    fileprivate let accountKey = "keychain.account"
    fileprivate let accessTokenKey = "keychain.accessToken"
    
    var email: String {
        get {
            return UserDefaults.standard.value(forKey: emailKey) as? String ?? ""
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: emailKey)
        }
    }
    
    var password: String?
    var accessToken: String?
    
    fileprivate lazy var credentialsKeychain: BaseKeychainModel = {
        return BaseKeychainModel(service: self.accountKey)
    }()
    
    fileprivate lazy var accessTokenKeychain: BaseKeychainModel = {
        return BaseKeychainModel(service: self.accessTokenKey)
    }()
    
    init() {
        if let password = credentialsKeychain.getCredentials(username: self.email)?.password {
            self.password = password
        }
        
        if let accessToken = accessTokenKeychain.getCredentials(username: self.email)?.password {
            self.accessToken = accessToken
        }
    }
    
    func saveCredentials(_ credentials: Credentials) {
        guard self.credentialsKeychain.saveCredentials(credentials) else { return }
        
        self.password = credentials.password
    }
    
    func saveAcceessToken(_ credentials: Credentials) {
        guard self.accessTokenKeychain.saveCredentials(credentials) else { return }
        
        self.accessToken = credentials.password
    }
    
    func updateAccessToken(_ accessToken: String) {
        guard self.accessTokenKeychain.updatePassword(credentials: Credentials(email: self.email, accessToken: accessToken)) else { return }
        
        self.accessToken = accessToken
    }
    
    func signOut() -> Bool {
        guard credentialsKeychain.deleteAccount(username: email),
              accessTokenKeychain.deleteAccount(username: email)
        else { return false }
        
        email       = ""
        password    = nil
        accessToken = nil
        return true
    }
}
