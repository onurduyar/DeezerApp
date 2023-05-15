//
//  AlbumListRequest.swift
//  DeezerCase
//
//  Created by Onur Duyar on 9.05.2023.
//

import Foundation

struct AlbumListRequest: APIRequest {
    typealias Response = AlbumListResponse
    let artistID: Int
    var url: String {
        Endpoint.artist.rawValue.appending(String(artistID)).appending(Endpoint.albums.rawValue)
    }
    var method: HTTPMethod {
        .get
    }
    init(by id: Int) {
        self.artistID = id
    }
    func decode(_ data: Data) throws -> AlbumListResponse {
        try JSONDecoder().decode(Response.self, from: data)
    }
}


