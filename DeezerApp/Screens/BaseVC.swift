//
//  BaseVC.swift
//  DeezerCase
//
//  Created by Onur Duyar on 11.05.2023.
//

import UIKit

class BaseViewController<T: UIView>: UIViewController {
    // Properties
    let baseViewModel: any BaseViewModel
    
    var contentView: T {
        return view as! T
    }
    
    // Init
    init(viewModel: any BaseViewModel) {
        self.baseViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // LifeCycle
    override func loadView() {
        view = T()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //baseViewModel.delegate = self
    }
    
    // Methods
    func fetchData(id :Int? = nil) {
        fatalError("fetchData must be overridden")
    }
}

// MARK: - BaseViewModelDelegate
extension BaseViewController: BaseViewModelDelegate {
    func onDataUpdated() {
        fatalError("onDataUpdated must be overridden")
    }
}
protocol BaseViewModelDelegate: AnyObject {
    func onDataUpdated()
}

protocol CollectionViewDelegate: AnyObject,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}
protocol TableViewDelegate: AnyObject,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
}
