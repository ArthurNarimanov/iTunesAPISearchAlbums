//
//  AlbumResult.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 27/11/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import Foundation
// MARK: - decodable json response for albums
struct AlbumResult: Decodable {
    
    let collectionId: Int
    let artistName: String?
    let collectionCensoredName: String?
    let artworkUrl100: String?
    let country: String?
    let primaryGenreName: String?
    let releaseDate: String?
    
}
