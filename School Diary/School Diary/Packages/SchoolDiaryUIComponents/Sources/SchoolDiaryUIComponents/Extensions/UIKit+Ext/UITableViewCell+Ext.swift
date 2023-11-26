//
//  UITableViewCell+Ext.swift
//
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit

extension UITableViewCell {
    static public var id: String {
        return String(describing: self.self)
    }
}
