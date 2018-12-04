//
//  SongTableViewCell.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 01/12/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import UIKit
// MARK: - show table songs
class SongTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLable: UILabel!
    @IBOutlet weak var songLable: UILabel!
  
    func setupSong(with song: SongResult){
        if let trackNumber = song.trackNumber {
        numberLable.text = "\(trackNumber)"
        }
        if let trackName = song.trackCensoredName {
            songLable.text = "\(trackName)"
        }

    }
    
}
