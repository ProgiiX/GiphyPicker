//
//  AMGifDataProvider.swift
//  Cadence
//
//  Created by Alexander Momotiuk on 09.01.18.
//  Copyright © 2018 Cadence. All rights reserved.
//

import Foundation
import GiphyCoreSDK

class AMGifDataProvider {
    
    private let client: GPHClient
    
    init(apiKey key: String) {
        self.client = GPHClient(apiKey: key)
    }
    
    func loadGiphy(_ search: String? = nil, offset: Int = 0, limit: Int, completion: @escaping (_ data: [AMGif]?) -> Void) {
        // Search
        if let search = search {
            getSearchGifs(search, offset: offset, limit: limit, completion: { (items) in
                completion(items)
            })
        }
        // Trending
        else {
            getTrendingGifs(offset: offset, limit: limit, completion: { (items) in
                completion(items)
            })
        }
    }
    
    private func getSearchGifs(_ search: String, offset: Int, limit: Int, completion: @escaping (_ data: [AMGif]?) -> Void) {
        client.search(search, offset: offset, limit: limit, completionHandler: { (responce, error) in
            guard let responceItems = responce?.data else {
                completion(nil)
                return
            }
            let gifs: [AMGif] = responceItems.map { return AMGif($0) }
            completion(gifs)
        })
    }
    
    private func getTrendingGifs(offset: Int, limit: Int, completion: @escaping (_ data: [AMGif]?) -> Void) {
        client.trending(offset: offset, limit: limit) { (responce, error) in
            guard let responceItems = responce?.data else {
                completion(nil)
                return
            }
            let gifs: [AMGif] = responceItems.map { return AMGif($0) }
            completion(gifs)
        }
    }
}
