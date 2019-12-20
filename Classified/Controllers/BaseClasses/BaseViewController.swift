//
//  BaseViewController.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showActivityIndicator(_ show: Bool) {
        if show {
            let indicator       = NVActivityIndicatorPresenter.sharedInstance
            let size            = CGSize(width: 50, height: 50)
            let type            = NVActivityIndicatorType.ballTrianglePath
            let activityView    = ActivityData(size: size, type: type, color: UIColor.brown)
            if !indicator       .isAnimating { indicator.startAnimating(activityView, nil) }
        } else {
            let indicator       = NVActivityIndicatorPresenter.sharedInstance
            if indicator        .isAnimating { indicator.stopAnimating(nil) }
        }
    }
    
    func showSystemAlert(withMessage message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
