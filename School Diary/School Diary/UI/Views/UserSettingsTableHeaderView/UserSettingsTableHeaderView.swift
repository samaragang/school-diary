//
//  UserSettingsTableHeaderView.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class UserSettingsTableHeaderView: BaseUIView {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = Constants.Images.userExampleAvatar.image
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        if let currentUser = RealmManager<LocalUserModel>().read().first {
            label.text = currentUser.nameAndSurname
        }
        
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = SettingsManager.shared.account.email
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)
        return stackView
    }()
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: 70)))
    }
}

// MARK: - Setup interface methods
extension UserSettingsTableHeaderView {
    override func setupLayout() {
        self.addSubview(userImageView)
        self.addSubview(infoStackView)
    }
    
    override func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(36)
            make.width.equalTo(self.frame.height - 10)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(userImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        self.layoutIfNeeded()
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
}
