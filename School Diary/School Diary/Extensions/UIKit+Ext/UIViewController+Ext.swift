//
//  UIViewController+Ext.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit

extension UIViewController {
    func configureNavigationController(title: String? = nil, preferesLargeTitles: Bool = true) -> UINavigationController {
        if let title {
            self.navigationItem.title = title
        }
        
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.navigationBar.prefersLargeTitles = preferesLargeTitles
        return navigationController
    }
}
