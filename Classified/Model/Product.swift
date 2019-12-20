//
//  Product.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation

struct Product: Codable {
    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case price
        case created_at
        case imageUrlsThumbnails = "image_urls_thumbnails"
        case imageUrls = "image_urls"
        case imageIDs = "image_ids"
    }

    var uid: String?
    var name: String?
    var price: String?
    var created_at: String?
    var imageUrlsThumbnails: [String]?
    var imageUrls: [String]?
    var imageIDs: [String]?
}

