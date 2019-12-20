//
//  ClassifiedCollectionViewCell.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import UIKit

class ClassifiedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    var product: Product? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        itemImageView.setImage(with: URL(string: product?.imageUrlsThumbnails?.first ?? ""), placeholder: UIImage(systemName: "baseline_cached_black_48pt"))
        itemNameLbl.text = "Product: \(product?.name ?? "N/A")"
        itemPriceLbl.text = "Price: $\(product?.price ?? "N/A")"
    }
}
