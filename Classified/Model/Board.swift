//
//  Board.swift
//  Classified
//
//  Created by Hanan on 12/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation

class Board: Codable {
    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
    
  var result: [Product]?
    
}
