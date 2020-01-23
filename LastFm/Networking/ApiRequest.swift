//
//  ApiRequest.swift
//  LastFm
//
//  Created by Josue Arambula on 1/22/20.
//  Copyright © 2020 Josue Arambula. All rights reserved.
//

import Foundation

class ApiRequest: NSObject {
    
    class func getAlbums(query: String,_ completionHandler:@escaping ( _ Array: AlbumDictionary?, _ err: Error? ) -> Void) {
        
        let endPoint = AppUrl.Domains.albumSearch + AppUrl.Domains.albumName + query + AppUrl.Domains.APIKey
        guard let url = URL(string: endPoint) else {
            print("Unable to get the endpoint")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("Unavailable data")
                return
            }
            do {
                let json = try JSONDecoder().decode(AlbumMatches.self, from: data)
                completionHandler(json.results, nil)
            } catch let requestError {
                print("Unable to get the response, cause: \(requestError)")
                completionHandler(nil, requestError)
            }
        }.resume()
        
        
        /*
         static let albumSearch = "http://ws.audioscrobbler.com/2.0/?method=album.search"
         static let albumName = "&album=" // "&album=[ALBUM_NAME]"
         static let APIKey = "&api_key=66275d7c0df9344f23cbbdecdc6ba3bf&format=json"
         static let limit = "&limit=" // optional, add a number at the end like "&limit=30"
         static let page = "&page=" // example "&page=1"
         */
        // http://ws.audioscrobbler.com/2.0/?method=album.search&album=believe&limit=3&api_key=66275d7c0df9344f23cbbdecdc6ba3bf&format=json
        
    }
    
}
