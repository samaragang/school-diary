//
//  UICollectionView+Ext.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 24.11.23.
//

import UIKit

extension UICollectionView {
    func register(_ cells: AnyClass...) {
        cells.forEach { cell in
            let id = String(describing: cell.self)
            self.register(cell, forCellWithReuseIdentifier: id)
        }
    }
}
