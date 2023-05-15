//
//  AlbumRequest.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import Foundation

struct AlbumRequest: APIRequest {
    typealias Response = AlbumResponse
    let albumID: Int
    var url: String {
        Endpoint.album.rawValue.appending(String(albumID)).appending(Endpoint.tracks.rawValue)
    }
    var method: HTTPMethod {
        .get
    }
    init(by id: Int) {
        self.albumID = id
    }
    func decode(_ data: Data) throws -> AlbumResponse {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
