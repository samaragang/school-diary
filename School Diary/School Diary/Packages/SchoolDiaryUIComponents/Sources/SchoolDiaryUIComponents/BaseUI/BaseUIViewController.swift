//
//  BaseUIViewController.swift
//
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit
import AlertKit

public protocol BaseUIViewControllerProtocol: AnyObject {
    func spinner(isShow: Bool)
}

open class BaseUIViewController: UIViewController {}

// MARK: -
// MARK: Lifecycle
extension BaseUIViewController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.setupInterface()
    }
}

// MARK: -
// MARK: Setup interface methods
extension BaseUIViewController {
    @objc open func setupInterface() {
        self.view.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        self.setupLayout()
        self.setupConstraints()
    }
    
    @objc open func setupLayout() {}
    @objc open func setupConstraints() {}
}

// MARK: -
// MARK: Keyboard
extension BaseUIViewController {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        self.view.endEditing(true)
    }
}

// MARK: - BaseUIViewControllerProtocol
extension BaseUIViewController: BaseUIViewControllerProtocol {
    public func spinner(isShow: Bool) {
        if isShow {
            AlertKitAPI.present(icon: .spinnerLarge, style: .iOS16AppleMusic)
        } else {
            AlertKitAPI.dismissAllAlerts()
        }
    }
}
