//
//  UIViewController+Ext
//
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

extension UIViewController {
    public var createNavigationController: UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
}
