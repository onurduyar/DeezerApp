//
//  ArtistDetailViewModel.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import Foundation

final class ArtistDetailViewModel: BaseViewModel {
    typealias Model = (type: RequestType, data: Any)
    
    static let shared = ArtistDetailViewModel()
    var data: Model?
    
    enum RequestType {
        case artist
        case albums
        
        var modelType: Codable.Type {
            switch self {
            case .artist:
                return Artist.self
            case .albums:
                return AlbumListResponse.self
            }
        }
    }
    func fetchData(by id: Int?,requestType: RequestType,completion: @escaping ((Result<Model?, Error>) -> Void )) {
        guard let id else {return}
        switch requestType {
        case .artist:
            BaseNetworkService().request(ArtistRequest(by: id)) { result in
                switch result {
                case .success(let response):
                    self.data = (type: .artist, data: response.self)
                    completion(.success(self.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .albums:
            BaseNetworkService().request(AlbumListRequest(by: id)) { result in
                switch result {
                case .success(let response):
                    self.data = (type: .albums, data: response.self)
                    completion(.success(self.data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
