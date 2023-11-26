//
//  UIImageView+Ext.swift
//
//
//  Created by Bahdan Piatrouski on 7.10.23.
//

import UIKit

extension UIImageView {
    public static var `default`: UIImageView {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
}
