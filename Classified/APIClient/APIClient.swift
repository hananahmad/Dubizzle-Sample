//
//  APIClient.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation
import Alamofire
import Reachability

final class APIClient {
    
    //MARK :- Shared Instance
    static let sharedInstance: APIClient = APIClient()
    
    let reachability = try? Reachability()
    
    private init() {
        networkReachability()
    }
    
    //MARK:-NetworkReachability
    func networkReachability() {
        reachability?.whenReachable = { reachability in
            DispatchQueue.main.async {
                if reachability.connection == .wifi {
                    
                } else {
                }
            }
        }
        reachability?.whenUnreachable = { reachability in
            DispatchQueue.main.async {
            }
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
        }
    }
    
    // Get Products List
    func getProductsList(completionHandler:  @escaping (Result<Any, Error>) -> Void) {
        
        let strURL = Constants.Endpoints.getProducts
        
        AF.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).validate()
            .responseJSON { response in
                
                guard let data = response.data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    
                    let productResponse = try decoder.decode(Board.self, from: data)
                    completionHandler(.success(productResponse))
                } catch let error {
                    print(error)
                    completionHandler(.failure(error))
                }
        }
    }
}
