//
//  PasswordTextField.swift
//
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

open class PasswordTextField: BaseUITextField {
    private lazy var hideButton: UIButton = {
        let button = UIButton()
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(hideButtonDidTap), for: .touchUpInside)
        return button
    }()
}

// MARK: -
// MARK: Setup textField methods
extension PasswordTextField {
    override public func setupTextField() {
        super.setupTextField()
        
        self.isSecureTextEntry = true
        self.rightView = self.hideButton
        self.rightViewMode = .always
    }
}

// MARK: -
// MARK: Actions
fileprivate extension PasswordTextField {
    @objc private func hideButtonDidTap(_ sender: UIButton) {
        self.isSecureTextEntry.toggle()
        UIView.transition(with: self.hideButton, duration: 0.2, options: .transitionCrossDissolve) { [weak self] in
            self?.hideButton.setImage(UIImage(systemName: (self?.isSecureTextEntry ?? true) ? "eye" : "eye.slash"), for: .normal)
        }
    }
}
