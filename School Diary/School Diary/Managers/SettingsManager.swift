//
//  SettingsManager.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation
import RealmSwift

final class SettingsManager {
    static let shared = SettingsManager()
    
    fileprivate init() {}
    
    // MARK: Realm configuration
    var realmConfiguration: Realm.Configuration {
        let configuration = Realm.Configuration(schemaVersion: 1)
        return configuration
    }
    
    let account = Account()
    
    func signOut() -> Bool {
        guard self.account.signOut() else { return false }
        
        RealmManager<LocalUserModel>().read().forEach({ RealmManager<LocalUserModel>().delete(object: $0) })
        
        return true
    }
}
