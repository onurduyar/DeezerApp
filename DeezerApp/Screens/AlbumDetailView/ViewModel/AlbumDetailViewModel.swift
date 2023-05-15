//
//  AlbumDetailViewModel.swift
//  DeezerCase
//
//  Created by Onur Duyar on 10.05.2023.
//

import Foundation

final class AlbumDetailViewModel: BaseViewModel {
    typealias Model = AlbumResponse
    
    static let shared = AlbumDetailViewModel()
    var data: Model?
    
    func fetchData(by id: Int?,completion: @escaping ((Result<Model?, Error>) -> Void )) {
        guard let id else {return}
        BaseNetworkService().request(AlbumRequest(by: id)) { result in
            switch result {
            case .success(let response):
                self.data = response.self
                completion(.success(self.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func calculateDuration(duration: Int?) -> String? {
        guard let duration else {return nil}
        let minute = duration / 60
        let second = duration % 60
        var minuteText = "\(minute)"
        var secondText = "\(second)"
        if (minute % 10) == minute{
           minuteText = "0\(minute)"
        }
        if (second % 10) == second{
            secondText = "0\(second)"
        }
        return "\(minuteText):\(secondText)"
    }
}

