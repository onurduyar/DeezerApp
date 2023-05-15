//
//  ArtistListRequest
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import Foundation

struct ArtistListRequest: APIRequest {
    typealias Response = ArtistListResponse
    let genreID: Int
    var url: String {
        Endpoint.genre.rawValue.appending(String(genreID)).appending(Endpoint.artists.rawValue)
    }
    var method: HTTPMethod {
        .get
    }
    init(by id: Int) {
        self.genreID = id
    }
    func decode(_ data: Data) throws -> ArtistListResponse {
        try JSONDecoder().decode(Response.self, from: data)
    }
}

