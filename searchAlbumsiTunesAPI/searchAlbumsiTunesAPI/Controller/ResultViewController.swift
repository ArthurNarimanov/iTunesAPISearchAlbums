//
//  ResultViewController.swift
//  searchAlbomsiTunesAPI
//
//  Created by Arthur Narimanov on 27/11/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import UIKit
// MARK: - class shows parameter albums and list of songs
class ResultViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorTableView: UIActivityIndicatorView!
    var collectionId:   Int =   0
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            DispatchQueue.main.async {
                if let image = self.album?.artworkUrl100 {
                    self.imageView.downloaded(from: image)
                }
            }
        }
    }
    @IBOutlet weak var albumNameLable: UILabel! {
        didSet {
            albumNameLable.text = self.album?.collectionCensoredName
        }
    }
    @IBOutlet weak var artistNameLable: UILabel! {
        didSet {
            artistNameLable.text = self.album?.artistName
        }
    }
    @IBOutlet weak var genreLable: UILabel! {
        didSet {
            genreLable.text = self.album?.primaryGenreName
        }
    }
    @IBOutlet weak var countryLable: UILabel! {
        didSet {
            countryLable.text = self.album?.country
        }
    }
    
    @IBOutlet weak var dateLable: UILabel! {
        didSet {
			// MARK: - Date format
			if let fullDateString = self.album?.releaseDate {
				
				let formatter = DateFormatter()
				formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
				
				if let date = formatter.date(from: fullDateString) {
					formatter.dateFormat = "yyyy"
					let yearString = formatter.string(from: date)
					dateLable.text = yearString
				}
			} else {
				dateLable.text = "No date"
			}
        }
    }
    
    
    @IBOutlet weak var songTableView: UITableView!
    
        var album: AlbumResult?
    
    var itemsSongArray: [SongResult] = [] {
        didSet{
            DispatchQueue.main.async {
                self.songTableView?.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collectionId = album?.collectionId {
        makeNetworkRequestSong(collectionId: collectionId)
            activityIndicatorTableView.startAnimating()
            songTableView.isHidden = true
        }
    }
	// MARK: - Network func search by album
    func makeNetworkRequestSong(collectionId: Int) {
        SearchSong().search(collectionId: collectionId) { (song) in
            if let song = song {
                DispatchQueue.main.async {
                    self.itemsSongArray += song
                    self.songTableView.isHidden = false
                    self.activityIndicatorTableView.stopAnimating()
                    self.songTableView.dataSource = self
                    self.songTableView.delegate = self
                    self.songTableView.reloadData()
                }
            }
        }
    }
    
}
// MARK: - Show list songs
extension ResultViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsSongArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = songTableView.dequeueReusableCell(withIdentifier: "cell") as? SongTableViewCell {
            cell.setupSong(with: itemsSongArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    
    
}
