//
//  AlbumDetail.swift
//  LastFm
//
//  Created by Josue Arambula on 1/22/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

import Foundation

struct AlbumDetail: Decodable {
    let album : [AlbumObjects]
}

struct AlbumObjects: Decodable {
    let name: String
    let artist: String
    let url: String
    let streamable: String
    let mbid: String
    let image: [ImageArray]
}

struct ImageArray: Decodable {
    var text : String
    var size: String
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}
