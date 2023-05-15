//
//  AlbumDetailVC.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import UIKit
import AVFoundation


final class AlbumDetailVC: BaseViewController<AlbumDetailView>{
    private var progressTimer: Timer?
    private let totalTime: TimeInterval = 30
    private var elapsedTime: TimeInterval = 0
    var player: AVPlayer?
    let albumDetailViewModel = AlbumDetailViewModel.shared
    var albumID: Int?
    var albumPicture: String?
    let albumdetailView = AlbumDetailView()
    var selectedTrackCell: TrackCell?
    var tracks: AlbumResponse?{
        didSet{
            DispatchQueue.main.async {
                self.contentView.refresh()
            }
        }
    }
    var favorites = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setTableViewDelegate(delegate: self, andDataSource: self)
        fetchTracks(by: albumID)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying(_:)), name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    func fetchTracks(by id: Int?) {
        guard let id else {return}
        albumDetailViewModel.fetchData(by: id) { result in
            switch result {
            case .success(let response):
                self.tracks = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
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
              let indexPath = contentView.tableView.indexPath(for: cell),
              let track = tracks?.data?[indexPath.row] else { return }
        track.albumCover = albumPicture
        track.isLike.toggle()
        cell.isFavorite.toggle()
        if !track.isLike{
            FavoritesViewModel.shared.deleteFromFavorites(track)
        }else {
            FavoritesViewModel.shared.addToFavorites(track: track)
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
}
extension AlbumDetailVC: TableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks?.data?.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TrackCell
        let track = tracks?.data?[indexPath.row]
        
     
        trackCell.title = track?.title
        trackCell.trackImageView.downloadImage(from: URL(string: albumPicture!))
        let duration = albumDetailViewModel.calculateDuration(duration: track?.duration)
        trackCell.length = duration
        let isContain =  FavoritesViewModel.shared.favorites?.contains(where: { $0.id == track?.id })
         if isContain ?? false{
             track?.isLike = true
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
        let track = tracks?.data?[indexPath.row]
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
