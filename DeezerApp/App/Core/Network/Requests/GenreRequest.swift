//
//  GenreRequest.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import Foundation

struct GenreRequest: APIRequest {
    
    typealias Response = GenreResponse
    var url: String {
        Endpoint.genre.rawValue
    }
    var method: HTTPMethod {
        .get
    }
    func decode(_ data: Data) throws -> GenreResponse {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
