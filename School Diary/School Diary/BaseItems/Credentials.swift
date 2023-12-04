//
//  Credentials.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import Foundation

struct Credentials {
    let username: String
    let password: String?
    
    init(username: String, password: String?) {
        self.username = username
        self.password = password
    }
    
    init(email: String, password: String?) {
        self.init(username: email, password: password)
    }
    
    init(email: String, accessToken: String?) {
        self.init(email: email, password: accessToken)
    }
}
