//
//  DashboardPresenter.swift
//  Classified
//
//  Created by Hanan on 12/20/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation

//==================================
// MARK: - View - Presenter Delegate
//==================================
protocol DashboardPresenterDelegate : class {
    func productsFetched()
    func showNoDataState()
    func showActivity(_ state: Bool)
    func showError(_ withMessage: String)
}

//==================================
// MARK: - Data Presenter
//==================================
class DashboardPresenter {
    
    //==================================
    // MARK: - Delegate Reference
    //==================================
    weak var delegate : DashboardPresenterDelegate?
    
    //==================================
    // MARK: - Variables
    //==================================
    var productsDataSource  = [Product]()
    
    //==================================
    // MARK: - Init / De-Init
    //==================================
    init() { }
    
    deinit { delegate = nil }
}

//==================================
// MARK: - Networking Calls
//==================================
extension DashboardPresenter {
    func fetchProducts() {
        if  APIClient.sharedInstance.reachability?.connection == .wifi || APIClient.sharedInstance.reachability?.connection == .cellular {
            delegate?.showActivity(true)
            APIClient.sharedInstance.getProductsList {
                [weak self] (Result) in
                self?.delegate?.showActivity(false)
                switch Result {
                case .success(let value):
                    if let productResponse = value as? Board {
                        self?.productsDataSource = productResponse.result ?? []
                        self?.delegate?.productsFetched()
                    }
                case .failure(let error):
                    self?.delegate?.showError(error.localizedDescription)
                }
            }
        } else { delegate?.showError("NO_INTERNET_AGAIN") }
    }
}

