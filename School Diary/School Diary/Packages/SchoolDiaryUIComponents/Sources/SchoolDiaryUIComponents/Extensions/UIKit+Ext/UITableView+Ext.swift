//
//  UITableView+Ext.swift
//
//
//  Created by Bahdan Piatrouski on 5.11.23.
//

import UIKit

extension UITableView {
    public func register(_ cells: AnyClass...) {
        cells.forEach { [weak self] cell in
            let id = String(describing: cell.self)
            self?.register(cell, forCellReuseIdentifier: id)
        }
    }
}
