//
//  SongResult.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 01/12/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import Foundation
// MARK: - decodable json response for songs
struct SongResult: Decodable {
    
    let collectionId: Int
    let trackCensoredName: String?
    let trackNumber: Int?
    
}
