//
//  SignPresenter.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

protocol SignPresenterProtocol {
    var signButtonHorizontalInsets: UIEdgeInsets { get }
    
    func signAction()
    func setView(_ view: SignViewControllerProtocol?)
}

final class SignPresenter: SignPresenterProtocol {
    private let controllerType: SignControllerType
    private weak var view: SignViewControllerProtocol?
    
    var signButtonHorizontalInsets: UIEdgeInsets {
        return UIEdgeInsets(horizontal: self.controllerType == .initialScreen ? 100 : 145)
    }
    
    init(withType controllerType: SignControllerType = .initialScreen) {
        self.controllerType = controllerType
    }
    
    func setView(_ view: SignViewControllerProtocol?) {
        self.view = view
    }
    
    func signAction() {
        if self.controllerType == .initialScreen {
            MainCoordinator.shared.pushSignController()
        } else {
            guard let email = view?.email,
                  let password = view?.password
            else { return }
            
            self.view?.spinner(isShow: true)
            SchoolsDiaryProvider.shared.signIn(email: email, password: password) { [weak self] user in
                let localUser = LocalUserModel(user: user)
                let realmManager = RealmManager<LocalUserModel>()
                realmManager.read().forEach({ realmManager.delete(object: $0) })
                realmManager.write(object: localUser)
                SettingsManager.shared.account.email = email
                SettingsManager.shared.account.saveCredentials(Credentials(email: email, password: password))
                SettingsManager.shared.account.saveAcceessToken(
                    Credentials(email: email, accessToken: user.accessToken.accessToken),
                    expireAt: user.accessToken.expireAt
                )
                
                self?.view?.spinner(isShow: false)
                MainCoordinator.shared.makeTabBarAsRoot()
            } failure: { [weak self] in
                self?.view?.spinner(isShow: false)
            }
        }
    }
}
