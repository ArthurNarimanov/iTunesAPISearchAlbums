//
//  AlbomCollectionViewCell.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 27/11/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import UIKit
// MARK: - Show collection cell 
class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameArtistLabel: UILabel!
    @IBOutlet weak var nameAlbumLable: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    
    var album: AlbumResult? {
        didSet {
            nameArtistLabel.text = album?.artistName
            nameAlbumLable.text = album?.collectionCensoredName
            
            self.activityIndicator.stopAnimating()
            
            self.imageView.image = UIImage(named: "")
            if self.imageView.image == UIImage(named: "") {
                self.activityIndicator.startAnimating()
            }
             DispatchQueue.main.async {
                if let image = self.album?.artworkUrl100 {
                    self.imageView.downloaded(from: image)
                }
            }
        }
    }
}


