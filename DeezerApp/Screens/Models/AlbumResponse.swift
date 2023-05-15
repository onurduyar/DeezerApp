//
//  AlbumResponse.swift
//  DeezerCase
//
//  Created by Onur Duyar on 8.05.2023.
//

import Foundation

class AlbumResponse: Codable {
    var data: [Track]?
    let total: Int?
    init(data: [Track]? = nil, total: Int?) {
        self.data = data
        self.total = total
    }
}
class Track: Codable {
    let id: Int?
    let readable: Bool?
    let title, titleShort, titleVersion, isrc: String?
    let link: String?
    let duration, trackPosition, diskNumber, rank: Int?
    let explicitLyrics: Bool?
    let explicitContentLyrics, explicitContentCover: Int?
    let preview: String?
    let artist: Artist?
    let type: DatumType?
    var isLike: Bool = false
    var albumCover: String?

    enum CodingKeys: String, CodingKey {
        case id, readable, title
        case titleShort = "title_short"
        case titleVersion = "title_version"
        case isrc, link, duration
        case trackPosition = "track_position"
        case diskNumber = "disk_number"
        case rank
        case explicitLyrics = "explicit_lyrics"
        case explicitContentLyrics = "explicit_content_lyrics"
        case explicitContentCover = "explicit_content_cover"
        case preview
        case artist, type,albumCover
    }
    init(id: Int?, readable: Bool?, title: String?, titleShort: String?, titleVersion: String?, isrc: String?, link: String?, duration: Int?, trackPosition: Int?, diskNumber: Int?, rank: Int?, explicitLyrics: Bool?, explicitContentLyrics: Int?, explicitContentCover: Int?, preview: String?, artist: Artist?, type: DatumType?, isLike: Bool, albumCover: String? = nil) {
        self.id = id
        self.readable = readable
        self.title = title
        self.titleShort = titleShort
        self.titleVersion = titleVersion
        self.isrc = isrc
        self.link = link
        self.duration = duration
        self.trackPosition = trackPosition
        self.diskNumber = diskNumber
        self.rank = rank
        self.explicitLyrics = explicitLyrics
        self.explicitContentLyrics = explicitContentLyrics
        self.explicitContentCover = explicitContentCover
        self.preview = preview
        self.artist = artist
        self.type = type
        self.isLike = isLike
        self.albumCover = albumCover
    }
}

enum ArtistType: String, Codable {
    case artist = "artist"
}

enum DatumType: String, Codable {
    case track = "track"
}
