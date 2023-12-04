//
//  AccountModel.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

final class Account {
    fileprivate let emailKey = "userDefaults.email"
    fileprivate let expireAtKey = "userDefaults.expireAtKey"
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
    
    var expireAt: Int {
        get {
            return UserDefaults.standard.value(forKey: expireAtKey) as? Int ?? 0
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: expireAtKey)
        }
    }
    
    var password: String?
    var accessToken: String?
    
    var shouldRefreshToken: Bool {
        return Int(Date().timeIntervalSince1970) >= self.expireAt
    }
    
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
    
    func saveAcceessToken(_ credentials: Credentials, expireAt: Int) {
        guard self.accessTokenKeychain.saveCredentials(credentials) else { return }
        
        self.expireAt = expireAt
        self.accessToken = credentials.password
        self.expireAt = expireAt
    }
    
    func updateAccessToken(_ accessToken: String, expireAt: Int) {
        guard self.accessTokenKeychain.updatePassword(credentials: Credentials(email: self.email, accessToken: accessToken)) else { return }
        
        self.expireAt = expireAt
        self.accessToken = accessToken
    }
    
    func signOut() -> Bool {
        guard credentialsKeychain.deleteAccount(username: email),
              accessTokenKeychain.deleteAccount(username: email)
        else { return false }
        
        email       = ""
        expireAt    = 0
        password    = nil
        accessToken = nil
        RealmManager<LocalUserModel>().read().forEach({ RealmManager<LocalUserModel>().delete(object: $0) })
        return true
    }
}
