//
//  ApiResponse.swift
//  LastFm
//
//  Created by Josue Arambula on 1/22/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

import Foundation

// Json response, headers
struct AlbumMatches: Decodable {
    let results: AlbumDictionary
}

// Json response, list object
struct AlbumDictionary: Decodable {
    let albummatches: AlbumDetail
}

