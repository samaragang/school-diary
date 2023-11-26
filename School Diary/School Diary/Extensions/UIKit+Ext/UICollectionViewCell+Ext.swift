//
//  UICollectionViewCell+Ext.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit

extension UICollectionViewCell {
    static var id: String {
        return String(describing: self.self)
    }
}
