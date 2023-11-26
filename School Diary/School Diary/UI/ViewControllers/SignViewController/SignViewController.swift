//
//  SignViewController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit
import SchoolDiaryUIComponents
import SnapKit

protocol SignViewControllerProtocol: BaseUIViewControllerProtocol {
    var email: String? { get }
    var password: String? { get}
}

final class SignViewController: BaseUIViewController {
    private lazy var signBackgroundImageView: UIImageView = {
        let imageView = UIImageView.default
        imageView.image = Constants.Images.signBackground.image
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .luckiestGuyRegular(size: 32)
        label.textAlignment = .center
        label.text = "SCHOOL\nDIARY"
        label.numberOfLines = 0
        label.textColor = UIColor(hex: "#23295B")
        return label
    }()
    
    private lazy var emailTextField: BaseUITextField = {
        let textField = BaseUITextField(placeholder: "Enter your email")
        textField.isHidden = true
        return textField
    }()
    
    private lazy var passwordTextField: PasswordTextField = {
        let textField = PasswordTextField(placeholder: "Enter your password")
        textField.isHidden = true
        return textField
    }()
    
    private lazy var resetPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forget password?", for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.isHidden = true
        return button
    }()
    
    private lazy var signButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(self, action: #selector(signAction), for: .touchUpInside)
        return button
    }()
    
    private var presenter: SignPresenterProtocol
    
    init(withType controllerType: SignControllerType = .initialScreen) {
        self.presenter = SignPresenter(withType: controllerType)
        super.init(nibName: nil, bundle: nil)
        self.presenter.setView(self)
        guard controllerType == .signScreen else { return }
        
        self.emailTextField.isHidden = false
        self.passwordTextField.isHidden = false
        self.resetPasswordButton.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: -
// MARK: Setup interface methods
extension SignViewController {
    override func setupLayout() {
        self.view.addSubview(signBackgroundImageView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(resetPasswordButton)
        self.view.addSubview(signButton)
    }
    
    override func setupConstraints() {
        signBackgroundImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(28)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(42)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(318)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(190)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
        }
        
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(passwordTextField.snp.top).offset(-24)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.bottom.equalTo(resetPasswordButton.snp.top).offset(-29)
            make.leading.trailing.equalToSuperview().inset(UIEdgeInsets(horizontal: 20))
            make.height.equalTo(44)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.bottom.equalTo(signButton.snp.top).offset(-33)
            make.leading.equalToSuperview().offset(258)
            make.trailing.equalToSuperview().inset(20)
        }
        
        signButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(24)
            make.leading.trailing.equalToSuperview().inset(self.presenter.signButtonHorizontalInsets)
            make.height.equalTo(48)
        }
    }
}

// MARK: -
// MARK: Actions
fileprivate extension SignViewController {
    @objc func signAction(_ sender: UIButton) {
        self.presenter.signAction()
    }
}

// MARK: - SignViewControllerPresenter
extension SignViewController: SignViewControllerProtocol {
    var email: String? {
        get {
            return self.emailTextField.text
        }
    }
    
    var password: String? {
        get {
            return self.passwordTextField.text
        }
    }
}
