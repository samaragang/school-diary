//
//  PupilTabBarController.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit

final class PupilTabBarController: UITabBarController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureViewControllers()
        self.tabBar.tintColor = UIColor(red: 0.35, green: 0.34, blue: 0.84, alpha: 1)
    }
    
    private func configureViewControllers() {
        let pupilVC = PupilViewController().configureNavigationController(title: "Аккаунт ученика", preferesLargeTitles: false)
        pupilVC.tabBarItem = UITabBarItem(title: "Профиль", image: Constants.Images.profileIcon.image, tag: 1)
        
        let timetableVC = TimetableViewController().configureNavigationController(preferesLargeTitles: false)
        timetableVC.tabBarItem = UITabBarItem(title: "Расписание", image: Constants.Images.timetableIcon.image, tag: 2)
        
        self.viewControllers = [
            pupilVC,
            timetableVC
        ]
    }
}
