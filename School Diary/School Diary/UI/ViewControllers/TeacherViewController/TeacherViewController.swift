//
//  TeacherViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit

final class TeacherViewController: UserViewController {
    private lazy var classButton: UIButton = {
        let button = UIButton()
        button.setTitle("Мой класс", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup interface methods
extension TeacherViewController {
    override func setupLayout() {
        super.setupLayout()
        self.view.addSubview(classButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        classButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-32)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 131))
            make.height.equalTo(48)
        }
    }
}
