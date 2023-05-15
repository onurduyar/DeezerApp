//
//  AlbumDetailView.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import UIKit

final class AlbumDetailView: UIView {
    // MARK: - Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
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
        setupTableView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // Methods
    func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TrackCell.self, forCellReuseIdentifier: "tableViewCell")
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
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
