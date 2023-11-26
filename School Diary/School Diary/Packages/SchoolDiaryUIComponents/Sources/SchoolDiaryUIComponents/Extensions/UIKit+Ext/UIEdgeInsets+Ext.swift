//
//  UIEdgeInsets+Ext
//
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

extension UIEdgeInsets {
    public init(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
        self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }
}
