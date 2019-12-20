//
//  Constants.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation

struct Constants {
    
    private struct DomainUrl {
        
        static let UATStaging    = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/"
        
        static let UAT = UATStaging
    }
    
    private static let domain = DomainUrl.UAT
    
    struct Endpoints {
        
        // Get Products API
        static let getProducts = domain + "dynamodb-writer"
    }
}
