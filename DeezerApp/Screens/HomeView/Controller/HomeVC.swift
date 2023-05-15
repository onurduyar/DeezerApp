//
//  HomeVC.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import UIKit

final class HomeVC: BaseViewController<MainView> {
    private var genres: [Genre]? {
        didSet{
            DispatchQueue.main.async {
                self.contentView.refresh()
            }
        }
    }
    override init(viewModel: any BaseViewModel) {
        super.init(viewModel: HomeViewModel.shared)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        contentView.setCollectionViewDelegate(delegate: self, andDataSource: self)
        fetchData()
        
    }
    override func fetchData(id: Int? = nil) {
        HomeViewModel.shared.fetchData() { result in
            switch result {
            case .success(let response):
                self.genres = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}
// MARK: - CollectionViewDelegate
extension HomeVC: CollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genres?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let genreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "mediaCell", for: indexPath) as! MediaCell
        let genre = genres?[indexPath.row]
        genreCell.title = genre?.name
        guard let picture = genre?.pictureMedium else {return genreCell}
        genreCell.imageView.downloadImage(from: URL(string: picture))
        return genreCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let genre = genres?[indexPath.row]
        let artistListVC = ArtistListVC(viewModel: ArtistListViewModel.shared)
        artistListVC.genre = genre
        navigationController?.pushViewController(artistListVC, animated: true)
    }
}

