//
//  HomeViewModel.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import Foundation

final class ArtistListViewModel: BaseViewModel {
    typealias Model = [Artist]
    
    static let shared = ArtistListViewModel()
    var data: Model?
    
    func fetchData(by id: Int?,completion: @escaping ((Result<Model?, Error>) -> Void )) {
        guard let id else {return}
        BaseNetworkService().request(ArtistListRequest(by: id)) { result in
            switch result {
            case .success(let response):
                self.data = response.data
                completion(.success(self.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
