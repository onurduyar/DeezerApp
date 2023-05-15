//
//  ArtistDetailView.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit

class ArtistDetailView: UIView {
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10.0
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    
    let tableView = UITableView()
    
    // MARK: - Init
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupImageView()
        setupTableView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Methods
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AlbumCell.self, forCellReuseIdentifier: "tableViewCell")
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10.0),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func setTableViewDelegate(delegate: UITableViewDelegate,
                                   andDataSource dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    func refresh() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
