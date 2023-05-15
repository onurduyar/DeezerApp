//
//  HomeView.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit

final class MainView: UIView {
    // MARK: - Properties
    private let cellInset: CGFloat = 8.0
    private let cellMultiplier = 0.5
    private var cellDimesion: CGFloat  {.screenWidth * cellMultiplier - cellInset}
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: cellDimesion, height: cellDimesion)
        return flowLayout
    }()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    
    // MARK: - Init
    init() {
        super.init(frame: .zero)
        setupCollectionViewLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    func setupCollectionViewLayout() {
        collectionView.register(MediaCell.self, forCellWithReuseIdentifier: "mediaCell")
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    func setCollectionViewDelegate(delegate: UICollectionViewDelegate,
                                   andDataSource dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    func refresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
