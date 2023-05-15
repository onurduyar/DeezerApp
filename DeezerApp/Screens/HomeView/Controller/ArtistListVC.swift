//
//  ArtistListVC.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit

final class ArtistListVC: BaseViewController<MainView>{
    var genreID: Int?
    var genre: Genre? {
        didSet{
            genreID = genre?.id
            title = genre?.name
        }
    }
    private var artists: [Artist]? {
        didSet{
            DispatchQueue.main.async {
                self.contentView.refresh()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.setCollectionViewDelegate(delegate: self, andDataSource: self)
        guard let genreID else {return}
        fetchData(id: genreID)
    }
    override func fetchData(id: Int? = nil) {
        guard let id else {return}
        ArtistListViewModel.shared.fetchData(by: id) { result in
            switch result {
            case .success(let response):
                self.artists = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
// MARK: - CollectionViewDelegate
extension ArtistListVC: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artists?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let artistCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MediaCell
        let artist = artists?[indexPath.row]
        artistCell.title = artist?.name
        guard let picture = artist?.pictureMedium else {return artistCell}
        artistCell.imageView.downloadImage(from: URL(string: picture))
        return artistCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
    }
}
