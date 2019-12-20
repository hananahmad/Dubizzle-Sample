//
//  UIImageView+Kingfisher.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func setImage(with url: URL?, placeholder: UIImage? = nil) {
        sd_imageIndicator = SDWebImageActivityIndicator.gray
        sd_setImage(with: url, placeholderImage: placeholder)
    }
    
    func cancelImageFetching() {
        sd_cancelCurrentImageLoad()
    }
}
