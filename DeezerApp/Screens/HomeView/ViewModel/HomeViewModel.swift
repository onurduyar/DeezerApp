//
//  ddd.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import Foundation

final class HomeViewModel: BaseViewModel{
    typealias Model = [Genre]
    static let shared = HomeViewModel()
    var data: Model?
    func fetchData(by id: Int? = nil, completion: @escaping ((Result<[Genre]?, Error>) -> Void)) {
        BaseNetworkService().request(GenreRequest()) { result in
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
