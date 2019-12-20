//
//  DashboardViewController.swift
//  Classified
//
//  Created by Hanan on 12/19/19.
//  Copyright © 2019 HANAN. All rights reserved.
//

import UIKit

class DashboardViewController: BaseViewController {
    
    //==================================
    // MARK: - Outlets
    //==================================
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    //==================================
    // MARK: - Variables
    //==================================
    var searchActive : Bool = false
    let searchController = UISearchController(searchResultsController: nil)
    
    let cellSizes: [CGFloat] = [180, 200, 220, 240, 290]
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(DashboardViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.darkGray
        
        return refreshControl
    }()
    
    //==================================
    // MARK: - Delegate Reference
    //==================================
    var presenter : DashboardPresenter?
    var selectedProduct: Product?
    var filtered:[Product] = []
    
    //==================================
    // MARK: - ViewLifeCycle
    //==================================
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRelations()
        setUI()
        fetchProductsList() //Fetching products from server
    }
    
    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchProductsList() //Fetching products from server
        
        refreshControl.endRefreshing()
    }
}

//==================================
// MARK: - Helping Functions
//==================================

extension DashboardViewController {
    private func setUI() {
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
        collectionView?.addSubview(refreshControl)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        
    }
    
    //Setup Presenter
    func setupRelations() {
        presenter = DashboardPresenter()
        presenter?.delegate = self
    }
    
    func fetchProductsList() {
        presenter?.fetchProducts()
    }
    
    func loadInitialData() {
        showNoDataView(false)
    }
    
    func showNoDataView(_ state: Bool?) {
        noDataView.isHidden = !(state ?? true)
        collectionView.reloadData()
    }
}

//==================================
// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
//==================================

extension DashboardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private struct Storyboard {
        static let ProductCellIdentifier = "ProductCellIdentifier"
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.ProductCellIdentifier,
                                                            for: indexPath) as? ClassifiedCollectionViewCell else { return UICollectionViewCell() }
        if searchActive {
            cell.product = filtered[indexPath.row]
        } else {
            if let products = self.presenter?.productsDataSource, products.count > 0 {
                cell.product = products[indexPath.row]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive {
            return filtered.count
        }
        else
        {
            return self.presenter?.productsDataSource.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchActive {
            if !filtered.isEmpty {
                self.selectedProduct = filtered[indexPath.row]
                self.performSegue(withIdentifier: "productDetailIdentifier", sender: self)
            }
        } else {
            if let products = self.presenter?.productsDataSource, products.count > 0 {
                self.selectedProduct = products[indexPath.row]
                self.performSegue(withIdentifier: "productDetailIdentifier", sender: self)
            }
        }
    }
}


//==================================
// MARK: - View - Presenter Delegate
//==================================
extension DashboardViewController : DashboardPresenterDelegate {
    func productsFetched() {
        loadInitialData()
    }
    
    func showNoDataState() {
        showNoDataView(true)
    }
    
    func showActivity(_ state: Bool) {
        showActivityIndicator(state)
    }
    
    func showError(_ withMessage: String) {
        showSystemAlert(withMessage: withMessage)
    }
}

//==================================
// MARK: - Navigations
//==================================
extension DashboardViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "productDetailIdentifier") {
            // pass data to next view
            if let productDetailViewController = segue.destination as? ProductDetailViewController {
                productDetailViewController.productImage = self.selectedProduct?.imageUrls?.first ?? ""
                productDetailViewController.productName = self.selectedProduct?.name ?? ""
                productDetailViewController.productPrice = self.selectedProduct?.price ?? ""
            }
        }
    }
}

extension DashboardViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let products = self.presenter?.productsDataSource, products.count > 0 {
                            let searchString = searchController.searchBar.text
                filtered = products.filter({$0.name == searchString})
                        }
                
                
                        collectionView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.dismiss(animated: true, completion: nil)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        collectionView.reloadData()
    }
}

//==================================
// MARK: - CUSTOM LAYOUT DELEGATE
//==================================

extension DashboardViewController: CustomLayoutDelegate {
    func collectionView(_: UICollectionView, heightForPhotoAtIndexPath _: IndexPath) -> CGFloat {
        guard let size = cellSizes.randomElement() else {
            return 120
        }
        
        return size
    }
}
