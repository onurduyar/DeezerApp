//
//  FavoritesVC.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit
import AVFoundation

class FavoritesVC: UIViewController {
    private var progressTimer: Timer?
    private let totalTime: TimeInterval = 30
    private var elapsedTime: TimeInterval = 0
    var player: AVPlayer?
    var favorites: [Track]? {
        didSet{
            DispatchQueue.main.async {
                self.trackView.refresh()
            }
        }
    }
    var selectedTrackCell: TrackCell?
    let trackView = AlbumDetailView()
    var albumPicture: String?
    let albumDetailViewModel = AlbumDetailViewModel.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view = trackView
        trackView.setTableViewDelegate(delegate: self, andDataSource: self)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.trackView.refresh()
        self.favorites = FavoritesViewModel.shared.favorites
        
    }
    private func startTimer() {
        progressTimer?.invalidate()
        progressTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }
    private func stopTimer() {
        progressTimer?.invalidate()
        elapsedTime = 0
        selectedTrackCell = nil
        player?.pause()
    }
    @objc private func updateProgressView() {
        elapsedTime += 1
        let progress = Float(elapsedTime / totalTime)
        selectedTrackCell?.progress = progress
        if progress >= 1 {
            stopTimer()
        }
    }
    @objc private func playerDidFinishPlaying(_ notification: Notification) {
        stopTimer()
    }
    @objc func likeButtonPressed(_ sender: UIButton) {
        guard let cell = sender.superview as? TrackCell,
              let indexPath = trackView.tableView.indexPath(for: cell),
              let track = favorites?[indexPath.row] else { return }
        track.albumCover = albumPicture
        track.isLike.toggle()
        cell.isFavorite.toggle()
        
        if !track.isLike{
            FavoritesViewModel.shared.deleteFromFavorites(track)
        }else {
            FavoritesViewModel.shared.addToFavorites(track: track)
        }
        self.trackView.refresh()
        self.favorites = FavoritesViewModel.shared.favorites
        
    }
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
}

extension FavoritesVC: TableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TrackCell
        guard  let track = favorites?[indexPath.row] else {return trackCell}
        trackCell.title = track.title
        trackCell.trackImageView.downloadImage(from: URL(string: track.albumCover ?? ""))
        let duration = albumDetailViewModel.calculateDuration(duration: track.duration)
        trackCell.length = duration
        
        if track.isLike{
            trackCell.isFavorite = true
        }else{
            trackCell.isFavorite = false
        }
        let isContain =  FavoritesViewModel.shared.favorites?.contains(where: { $0.id == track.id })
        if isContain ?? false{
            track.isLike = true
            trackCell.isFavorite = true
        }
        trackCell.likeButton.addTarget(self, action: #selector(likeButtonPressed(_:)), for: .touchUpInside)
        return trackCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTrackCell?.isPlaying = false
        
        guard let cell = tableView.cellForRow(at: indexPath) as? TrackCell else{return}
        if let player = self.player, player.rate > 0 {
            stopTimer()
        }
        selectedTrackCell = cell
        let track = favorites?[indexPath.row]
        let trackURL = track?.preview
        
        player = AVPlayer(url: URL(string: trackURL!)!)
        player?.play()
        selectedTrackCell?.isPlaying = true
        startTimer()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        135
    }

    
}
