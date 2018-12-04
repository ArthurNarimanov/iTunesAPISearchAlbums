//
//  SearchAlbums.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 27/11/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

//MARK: - search and sorted albums
import Foundation
class SearchAlbums {
    func search(nameSearch: String, completion: @escaping ([AlbumResult]?, Int) -> Void) {
        let limit: Int = 200 // this is max for API iTunes
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(nameSearch.replacingOccurrences(of: " ", with: "+"))&entity=album&attribute=albumTerm&limit=\(limit).") else { return }
        
        let sesseon = URLSession.shared
        sesseon.dataTask(with: url) { (data, response , error) in
            guard let response = response as?           HTTPURLResponse,
                response.statusCode == 200 else { return completion(nil, 0)}
            
            if let data = data {
                do {
                    var json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    let decoder = JSONDecoder()
                        if let jsonData = json["results"], let jsonResultCount = json["resultCount"]{
                            
                            if let albumData = try? JSONSerialization.data(withJSONObject: jsonData, options: []) {
                                var albumsArray = try decoder.decode([AlbumResult].self, from: albumData)
                                
                                // albums sorting alphabetically
                                albumsArray.sort(by: { (left: AlbumResult, right: AlbumResult) -> Bool in
                                    return  left.collectionCensoredName! < right.collectionCensoredName!
                                })
                                
                                completion(albumsArray, jsonResultCount as! Int)
                            }
                        }
                } catch {
                    completion(nil, 0)
                }
            } else {
                completion(nil, 0)
            }
        } .resume()
    }
}
