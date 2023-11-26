//
//  UserInfoView.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class UserInfoView: BaseUIView {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = Constants.Images.userExampleAvatar.image
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        if let currentUser = RealmManager<LocalUserModel>().read().first {
            label.text = currentUser.nameAndSurname
        }
        
        return label
    }()
    
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "ГУО \"Гимназия 8 г. Минска\n"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(schoolLabel)
        return stackView
    }()
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: 302, height: 138)))
    }
}

// MARK: - Setup interface methods
extension UserInfoView {
    override func setupInterface() {
        super.setupInterface()
        self.layer.cornerRadius = 16
        self.backgroundColor = .white
    }
    
    override func setupLayout() {
        self.addSubview(userImageView)
        self.addSubview(infoStackView)
    }
    
    override func setupConstraints() {
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-19)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23)
            make.bottom.equalToSuperview().offset(-23)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalTo(userImageView.snp.trailing).offset(24)
        }
        
        self.layoutIfNeeded()
        
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
}
