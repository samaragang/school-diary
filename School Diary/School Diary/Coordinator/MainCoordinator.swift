//
//  MainCoordinator.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit
import SchoolDiaryUIComponents

final class MainCoordinator: NSObject {
    static let shared = MainCoordinator()
    
    var window: UIWindow?
    
    fileprivate override init() {
        super.init()
    }
    
    let signVC = SignViewController().createNavigationController
    
    var tabBar: UITabBarController? {
        guard let currentUser = RealmManager<LocalUserModel>().read().first else { return nil }
        
        let tabBar: UITabBarController?
        switch currentUser.role {
            case .pupil:
                tabBar = PupilTabBarController()
            case .teacher:
                tabBar = TeacherTabBarController()
            default:
                tabBar = nil
        }
        
        tabBar?.delegate = self
        return tabBar
    }
    
    var initialController: UIViewController? {
        if SettingsManager.shared.account.accessToken?.isEmpty ?? true {
            return self.signVC
        } else {
            let account = SettingsManager.shared.account
            if account.shouldRefreshToken {
                SchoolsDiaryProvider.shared.signIn(email: account.email, password: account.password ?? "") { [weak self] user in
                    let localUser = LocalUserModel(user: user)
                    let realmManager = RealmManager<LocalUserModel>()
                    realmManager.read().forEach({ realmManager.delete(object: $0) })
                    realmManager.write(object: localUser)
                    SettingsManager.shared.account.updateAccessToken(user.accessToken.accessToken, expireAt: user.accessToken.expireAt)
                    self?.makeTabBarAsRoot()
                } failure: { [weak self] in
                    _ = SettingsManager.shared.signOut()
                    self?.makeSignVCAsRoot()
                }
                
                return nil
            } else {
                return self.tabBar
            }
        }
    }
    
    var currentController: UIViewController? {
        guard let rootController = UIApplication.shared.currentWindow?.rootViewController else { return nil }
        
        var currentController: UIViewController! = rootController
        while currentController.presentedViewController != nil {
            currentController = currentController.presentedViewController
        }
        
        if let currentTabBar = currentController as? UITabBarController {
            currentController = currentTabBar.selectedViewController
        }
        
        return currentController
    }
}

// MARK: -
// MARK: Open controller methods (push/present)
fileprivate extension MainCoordinator {
    func pushViewController(_ vc: UIViewController, animated: Bool = true) {
        DispatchQueue.main.async { [weak self] in
            (self?.currentController as? UINavigationController)?.pushViewController(vc, animated: animated)
        }
    }
    
    func present(_ vc: UIViewController, animated: Bool = true, completion: (() -> ())? = nil) {
        DispatchQueue.main.async { [weak self] in
            self?.currentController?.present(vc, animated: animated, completion: completion)
        }
    }
    
    func makeRootVC(_ vc: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            self?.window?.rootViewController = vc
            self?.window?.makeKeyAndVisible()
        }
    }
}

// MARK: -
// MARK: Open controllers methods
extension MainCoordinator {
    func pushSignController() {
        self.pushViewController(SignViewController(withType: .signScreen))
    }
    
    func pushSettingsController() {
        self.pushViewController(SettingsViewController())
    }
    
    func makeTabBarAsRoot() {
        guard let tabBar else { return }
        
        self.makeRootVC(tabBar)
    }
    
    func makeSignVCAsRoot() {
        self.makeRootVC(SignViewController().createNavigationController)
    }
    
    func presentQRScanner() {
        self.present(QRScannerViewController())
    }
    
    func pushUserViewController(userInfo: ResponseUserBaseModel) {
        self.pushViewController(UserViewController(controllerType: .pupilInfo, userInfo: userInfo))
    }
    
    func pushScheduleViewController(dayType: TimetableDaysType, day: Date, isCurrentWeek: Bool) {
        self.pushViewController(ScheduleViewController(dayType: dayType, day: day, isCurrentWeek: isCurrentWeek))
    }
    
    func pushLessonInfoViewController(lesson: ResponseLessonModel, day: Date, dateType: TimetableDaysType) {
        self.pushViewController(LessonInfoViewController(with: lesson, day: day, dateType: dateType))
    }
    
    func pushLessonMarksViewController(lesson: ResponseLessonModel, day: Date, dateType: TimetableDaysType) {
        self.pushViewController(LessonMarksViewController(lesson: lesson, date: day, type: dateType))
    }
    
    func pushChooseMarkViewController(pupil: ResponseShortUserInfoModel, completion: @escaping ChooseMarkCompletion) {
        self.pushViewController(ChooseMarkViewController(withPupil: pupil, completion: completion))
    }
}

// MARK: - UITabBarControllerDelegate
extension MainCoordinator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return !(viewController is QRScannerViewController)
    }
}
