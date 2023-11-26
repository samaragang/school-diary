//
//  MainCoordinator.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit
import SchoolDiaryUIComponents

final class MainCoordinator {
    static let shared = MainCoordinator()
    
    var window: UIWindow?
    
    fileprivate init() {}
    
    let signVC = SignViewController().createNavigationController
    
    var tabBar: UITabBarController? {
        guard let currentUser = RealmManager<LocalUserModel>().read().first else { return nil }
        
        switch currentUser.role {
            case .pupil:
                return PupilTabBarController()
            case .teacher:
                return TeacherTabBarController()
            default:
                break
        }
        
        return nil
    }
    
    var initialController: UIViewController? {
        if SettingsManager.shared.account.accessToken?.isEmpty ?? true {
            return self.signVC
        } else {
            return self.tabBar
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
}
