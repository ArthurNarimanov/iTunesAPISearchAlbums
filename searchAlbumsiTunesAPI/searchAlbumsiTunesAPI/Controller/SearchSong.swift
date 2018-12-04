//
//  SearchSong.swift
//  searchAlbomsiTunesAPI
//
//  Created by Arthur Narimanov on 01/12/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import Foundation

//MARK: - search songs by albums
class SearchSong {
    func search(collectionId: Int, complection: @escaping ([SongResult]?)-> Void){
        guard let url = URL(string: "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song&attribute=songTerm&limit=200.") else { return }
        let sesseon = URLSession.shared
        sesseon.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            if let data = data {
                do {
                    var json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    if let jsonDate = json["results"] {
                        let decoder = JSONDecoder()
                        if let receptData = try? JSONSerialization.data(withJSONObject: jsonDate, options: []) {
                            var songsArray = try decoder.decode([SongResult].self, from: receptData)
                            songsArray.removeFirst()
                            // dump(songsArray)
                            complection(songsArray)
                        }
                    }
                } catch {
                    print("error date:")
                }
                
            } else {
                print("Error Date!")
            }
        }.resume()
    }
}
