//
//  TrackCell.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import UIKit

final class TrackCell: UITableViewCell {
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            trackImageView.image = image
        }
    }
    var title: String? {
        didSet {
            trackTitleLabel.text = title
        }
    }
    var length: String? {
        didSet {
            lengthLabel.text = length
        }
    }
    var progress:Float = 0 {
        didSet{
            progressView.progress = progress
        }
    }
    var isFavorite: Bool = false {
        didSet{
            if isFavorite {
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                
            }
        }
    }
    var isPlaying: Bool = false {
        didSet{
            if isPlaying{
                progressView.isHidden = false
                playButton.isHidden = true
                pauseButton.isHidden = false
                self.backgroundColor = UIColor(hex: "D4ADFC")
                likeButton.tintColor = .white
            }else{
                progressView.isHidden = true
                playButton.isHidden = false
                pauseButton.isHidden = true
                self.backgroundColor = .white
                likeButton.tintColor = UIColor(hex: "D4ADFC")
            }
        }
    }
    private(set) lazy var trackImageView: UIImageView = {
        let trackImageView = UIImageView()
        trackImageView.contentMode = .scaleAspectFit
        return trackImageView
    }()
    private lazy var trackTitleLabel: UILabel = {
        let trackTitleLabel = UILabel()
        trackTitleLabel.font = .systemFont(ofSize: 18)
        trackTitleLabel.textColor = .black
        trackTitleLabel.numberOfLines = .zero
        return trackTitleLabel
    }()
    private lazy var lengthLabel: UILabel = {
        let lengthLabel = UILabel()
        lengthLabel.font = .systemFont(ofSize: 13)
        lengthLabel.textColor = .darkGray.withAlphaComponent(0.75)
        lengthLabel.numberOfLines = .zero
        return lengthLabel
    }()
    private(set) lazy var playButton: UIButton = {
        let playButton = UIButton(type: .custom)
        playButton.tintColor = .systemOrange
        playButton.setImage(UIImage(systemName: "play"), for: .normal)
        return playButton
    }()
    
    private(set) lazy var pauseButton: UIButton = {
        let pauseButton = UIButton(type: .custom)
        pauseButton.tintColor = .white
        pauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        return pauseButton
    }()
    private(set) lazy var likeButton: UIButton = {
        let likeButton = UIButton(type: .roundedRect)
        likeButton.tintColor = .systemOrange
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return likeButton
    }()
    
    private(set) lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .systemOrange
        progressView.trackTintColor = .white
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.isHidden = true
        return progressView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
        setuptrackTitleLabel()
        setuplengthLabel()
        setupButtons()
        setupProgressView()
        setupLikeButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func setupImageView() {
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(trackImageView)
        NSLayoutConstraint.activate([
            trackImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trackImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            trackImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -200),
            trackImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    func setuptrackTitleLabel() {
        trackTitleLabel.textAlignment = .center
        trackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(trackTitleLabel)
        NSLayoutConstraint.activate([
            trackTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 150.0),
            trackTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            trackTitleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 20.0)
        ])
    }
    func setuplengthLabel() {
        lengthLabel.textAlignment = .center
        lengthLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lengthLabel)
        NSLayoutConstraint.activate([
            lengthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 150.0),
            lengthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            lengthLabel.topAnchor.constraint(equalTo: trackTitleLabel.topAnchor,constant: 20.0)
        ])
    }
    func setupButtons(){
        playButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: -30),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 30),
            playButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        pauseButton.isHidden = true
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pauseButton)
        NSLayoutConstraint.activate([
            pauseButton.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: -30),
            pauseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pauseButton.widthAnchor.constraint(equalToConstant: 30),
            pauseButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func setupLikeButton() {
        likeButton.tintColor = .systemOrange
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(likeButton)
        NSLayoutConstraint.activate([
            likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            likeButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 100),
            likeButton.heightAnchor.constraint(equalToConstant: 100)
        ])
        
    }

    func setupProgressView(){
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: trackImageView.trailingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -90),
            progressView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
