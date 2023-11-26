//
//  UserViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit
import SchoolDiaryUIComponents

class UserViewController: BaseUIViewController {
    private lazy var userInfoView: UserInfoView = {
        let userInfoView = UserInfoView()
        return userInfoView
    }()
    
    private lazy var qrImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Constants.Images.userExampleQR.image
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -
// MARK: Setup interface methods
extension UserViewController {
    override func setupInterface() {
        super.setupInterface()
        self.setupNavigationController()
    }
    
    override func setupLayout() {
        self.view.addSubview(userInfoView)
        self.view.addSubview(qrImageView)
    }
    
    override func setupConstraints() {
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
        }
        
        qrImageView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(280)
        }
    }
    
    private func setupNavigationController() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Constants.Images.settingsIcon.image,
            style: .done,
            target: self,
            action: #selector(openSettingsAction)
        )
        
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
}

// MARK: - Actions
private extension UserViewController {
    @objc private func openSettingsAction() {
        MainCoordinator.shared.pushSettingsController()
    }
}
