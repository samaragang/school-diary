//
//  UIImageView+Ext.swift
//  School Diary
//
//  Created by Bahdan Piatrouski on 25.11.23.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(from link: String?) {
        guard let link else { return }
        
        SDWebImageManager.shared.loadImage(with: URL(string: link), progress: nil) { [weak self] image, _, _, cacheType, _, _ in
            self?.setImage(image, cacheType: cacheType)
        }
    }
    
    func setImage(from link: String?, withHeader header: String?) {
        guard let link,
              let header
        else { return }
        
        let imageDownloader = SDWebImageDownloader.shared
        imageDownloader.setValue(header, forHTTPHeaderField: "X-Schools-Token")
        imageDownloader.downloadImage(with: URL(string: link)) { [weak self] image, _, _, _ in
            self?.setImage(image, cacheType: .none)
        }
    }
    
    private func setImage(_ image: UIImage?, cacheType: SDImageCacheType) {
        self.image = image
        guard cacheType == .none else { return }
        
        self.alpha = 0
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = 1
        }
    }
}
