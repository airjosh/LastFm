//
//  ApiEndPoints.swift
//  LastFm
//
//  Created by Josue Arambula on 1/22/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

import Foundation

struct AppUrl {
    
    struct Domains {
        
        // http request as a URL parameter is for example
        // JSON: /2.0/?method=album.search&album=believe&api_key=YOUR_API_KEY&format=json
        
        // Mark: - Required
        static let albumSearch = "http://ws.audioscrobbler.com/2.0/?method=album.search"
        static let albumName = "&album=" // "&album=[ALBUM_NAME]"
        static let APIKey = "&api_key=66275d7c0df9344f23cbbdecdc6ba3bf&format=json"
        
        // Mark: - Optionals
        static let limit = "&limit=" // optional, add a number at the end like "&limit=30"
        static let page = "&page=" // example "&page=1"
        
        // complete example:
        // http://ws.audioscrobbler.com/2.0/?method=album.search&album=believe&limit=3&api_key=66275d7c0df9344f23cbbdecdc6ba3bf&format=json
        
    }
    
}


