//
//  Constants.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

enum Constants {
    enum Images {
        case signBackground
        case userExampleAvatar
        case userExampleQR
        case settingsIcon
        case signOutIcon
        case profileIcon
        case menuNavigationButtonIcon
        case timetableIcon
        
        var image: UIImage? {
            switch self {
                case .signBackground:
                    return UIImage(named: "SignBackground")
                case .userExampleAvatar:
                    return UIImage(named: "UserAvatarExample")
                case .userExampleQR:
                    return UIImage(named: "UserQRExample")
                case .settingsIcon:
                    return UIImage(named: "SettingsIcon")
                case .signOutIcon:
                    return UIImage(named: "SignOutIcon")
                case .profileIcon:
                    return UIImage(named: "AccountTabBarIcon")
                case .menuNavigationButtonIcon:
                    return UIImage(named: "MenuNavigationButtonIcon")
                case .timetableIcon:
                    return UIImage(named: "TimetableTabBarIcon")
            }
        }
    }
    
    static var isDebug: Bool {
#if DEBUG
        return true
#endif
        return false
    }
}
