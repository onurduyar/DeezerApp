//
//  MediaCell.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit

final class MediaCell: UICollectionViewCell {
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
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = .zero
        return titleLabel
    }()
    private lazy var gradientLayer: CAGradientLayer = {
           let layer = CAGradientLayer()
           layer.startPoint = CGPoint(x: 0.5, y: 0.0)
           layer.endPoint = CGPoint(x: 0.5, y: 1.0)
           layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
           layer.locations = [0.0, 1.0]
           return layer
       }()
    
   // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupImageView()
        setupTitleLabel()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Methods
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10.0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10.0),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        imageView.layer.insertSublayer(gradientLayer, at: .zero)
    }
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor,constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8.0),
            titleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -8.0)
        ])
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
