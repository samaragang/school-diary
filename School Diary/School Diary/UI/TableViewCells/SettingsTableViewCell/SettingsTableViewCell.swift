//
//  SettingsTableViewCell.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit
import SchoolDiaryUIComponents

enum SettingsTableViewCellType {
    case button
    case `switch`
}

final class SettingsTableViewCell: BaseUITableViewCell {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private lazy var actionSwitch: UISwitch = {
        let `switch` = UISwitch()
        `switch`.isHidden = true
        `switch`.addTarget(self, action: #selector(controlAction), for: .valueChanged)
        return `switch`
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(controlAction), for: .touchUpInside)
        button.isHidden = true
        button.layer.cornerRadius = 24
        return button
    }()
    
    private lazy var actionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(actionSwitch)
        view.addSubview(actionButton)
        view.addSubview(actionImageView)
        view.layer.cornerRadius = 24
        return view
    }()
    
    private var actionClosure: ((_ switchValue: Bool?) -> ())?
    private var type: SettingsType?
    
    func setupCell(type: SettingsType, action: @escaping((_ switchValue: Bool?) -> ())) {
        self.type = type
        self.actionClosure = action
        
        titleLabel.text = type.title
        actionImageView.image = type.buttonImage
        self.selectionStyle = type.selectionStyle
        switch type.cellType {
            case .button:
                self.actionButton.isHidden = false
                self.actionImageView.isHidden = false
            case .switch:
                self.actionSwitch.isHidden = false
        }
    }
}

// MARK: - Setup interface methods
extension SettingsTableViewCell {
    override func setupInterface() {
        super.setupInterface()
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    override func setupLayout() {
        self.contentView.addSubview(mainView)
    }
    
    override func setupConstraints() {
        self.mainView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(UIEdgeInsets(vertical: 10))
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
        }
        
        self.actionSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-17)
            make.centerY.equalToSuperview()
        }
        
        self.actionButton.snp.makeConstraints({ $0.edges.equalToSuperview() })
        
        self.actionImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-17)
            make.centerY.equalToSuperview()
        }
    }
}

// MARK: - Actions
fileprivate extension SettingsTableViewCell {
    @objc func controlAction() {
        if self.type?.cellType == .switch {
            self.actionClosure?(self.actionSwitch.isOn)
        } else {
            self.actionClosure?(nil)
        }
    }
}
