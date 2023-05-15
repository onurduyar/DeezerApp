//
//  AlbumCell.swift
//  DeezerCase
//
//  Created by Onur Duyar on 9.05.2023.
//

import UIKit

final class AlbumCell: UITableViewCell {
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            albumImageView.image = image
        }
    }
    var title: String? {
        didSet {
            albumTitleLabel.text = title
        }
    }
    var releaseDate: String? {
        didSet {
            releaseDateLabel.text = releaseDate
        }
    }
    
    private(set) lazy var albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var albumTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    private lazy var releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.font = .systemFont(ofSize: 18)
        releaseDateLabel.textColor = .darkGray.withAlphaComponent(0.75)
        releaseDateLabel.numberOfLines = .zero
        return releaseDateLabel
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setupAlbumTitleLabel()
        setupReleaseDateLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    func setupImageView() {
        albumImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(albumImageView)
        NSLayoutConstraint.activate([
            albumImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            albumImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            albumImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -200),
            albumImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setupAlbumTitleLabel() {
        albumTitleLabel.textAlignment = .center
        albumTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(albumTitleLabel)
        NSLayoutConstraint.activate([
            albumTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 150.0),
            albumTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            albumTitleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 20.0)
        ])
    }
    func setupReleaseDateLabel() {
        releaseDateLabel.textAlignment = .center
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(releaseDateLabel)
        NSLayoutConstraint.activate([
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 150.0),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            releaseDateLabel.topAnchor.constraint(equalTo: albumTitleLabel.topAnchor,constant: 40.0)
        ])
    }
}
