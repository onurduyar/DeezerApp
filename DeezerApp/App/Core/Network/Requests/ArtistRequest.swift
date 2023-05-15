//
//  ArtistRequest.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import Foundation
// https://api.deezer.com/artist/artist_id

struct ArtistRequest: APIRequest {
    typealias Response = Artist
    let artistID: Int
    var url: String {
        Endpoint.artist.rawValue.appending(String(artistID))
    }
    var method: HTTPMethod {
        .get
    }
    init(by id: Int) {
        self.artistID = id
    }
    func decode(_ data: Data) throws -> Artist {
        try JSONDecoder().decode(Response.self, from: data)
    }
}
