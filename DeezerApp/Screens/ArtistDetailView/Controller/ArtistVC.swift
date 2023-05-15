//
//  ArtistVC.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit

final class ArtistVC: BaseViewController<ArtistDetailView> {
    var artistPhoto: String?
    var artistID: Int?
    var albums: AlbumListResponse? {
        didSet{
            DispatchQueue.main.async {
                self.contentView.refresh()
            }
        }
    }
    private var artist: Artist? {
        didSet{
            artistID = artist?.id
            self.artistPhoto = artist?.pictureMedium
            DispatchQueue.main.async {
                self.title = self.artist?.name
                self.contentView.imageView.downloadImage(from: URL(string: self.artistPhoto!))
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let artistID else {return}
        fetchArtist(by: artistID)
        fetchAlbumList(by: artistID)
        contentView.setTableViewDelegate(delegate: self, andDataSource: self)
    }
    func fetchArtist(by artistID: Int?) {
        guard let artistID else {return}
        ArtistDetailViewModel.shared.fetchData(by: artistID, requestType: .artist) { result in
            switch result {
            case .success(let response):
                if let artist = response?.data as? Artist {
                    self.artist = artist
                } else {
                    fatalError("Response is not of type Artist")
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    func fetchAlbumList(by artistID: Int?) {
        guard let artistID else {return}
        ArtistDetailViewModel.shared.fetchData(by: artistID, requestType: .albums) { result in
            switch result {
            case .success(let response):
                if let albums = response?.data as? AlbumListResponse {
                    self.albums = albums
                } else {
                    fatalError("Response is not of type AlbumListResponse")
                }
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
// MARK: - TableViewDelegate
extension ArtistVC: TableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.albums?.data?.count ?? .zero
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let albumCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell") as! AlbumCell
        guard let album = albums?.data?[indexPath.row] else {return albumCell}
        albumCell.title = album.title
        albumCell.releaseDate = album.releaseDate
        albumCell.albumImageView.downloadImage(from: URL(string: album.coverMedium!))
        return albumCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        135
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums?.data?[indexPath.row]
         let albumDetailVC = AlbumDetailVC(viewModel: AlbumDetailViewModel.shared)
         albumDetailVC.albumID = album?.id
         albumDetailVC.albumPicture = album?.coverMedium
         navigationController?.pushViewController(albumDetailVC, animated: true)
    }
}
