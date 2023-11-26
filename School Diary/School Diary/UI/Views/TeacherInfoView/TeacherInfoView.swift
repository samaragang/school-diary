//
//  TeacherInfoView.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit
import SchoolDiaryUIComponents

final class TeacherInfoView: BaseUIView {
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = Constants.Images.userExampleAvatar.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var teacherLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Классный руководитель"
        return label
    }()
    
    private lazy var teacherNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        if let teacher = RealmManager<LocalTeacherModel>().read().first {
            label.text = teacher.nameAndSurname
        }
        
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.addArrangedSubview(teacherLabel)
        stackView.addArrangedSubview(teacherNameLabel)
        return stackView
    }()
    
    convenience init() {
        self.init(frame: CGRect(origin: .zero, size: CGSize(width: 350, height: 86)))
    }
    
    func updateTeacherInfo() {
        self.teacherNameLabel.text = RealmManager<LocalTeacherModel>().read().first?.nameAndSurname
    }
}

// MARK: - Setup interface methods
extension TeacherInfoView {
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
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(vertical: 18))
            make.leading.equalToSuperview().offset(24)
        }
        
        infoStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(vertical: 19))
            make.trailing.equalToSuperview().offset(-45)
            make.leading.equalTo(userImageView.snp.trailing).offset(24)
        }
        
        self.layoutIfNeeded()
        
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
}

@available(iOS 17.0, *)
#Preview {
    return TeacherInfoView()
}
