//
//  SearchViewController.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 27/11/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import UIKit
// MARK: - class search and shows albums
class SearchViewController: UIViewController {

    @IBOutlet weak var searchBarAlbums: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorSearch: UIActivityIndicatorView!

    var searchText: String = ""
    
    var itemsAlbumsArray: [AlbumResult] = [] {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBarAlbums.delegate = self
    }
	// MARK: - Network func search albums
    func makeNetworkRequest(errorHandler: (() -> Void)?) {
        guard let searchText = searchBarAlbums.text else { return }
        if searchText != "" {
            SearchAlbums().search(nameSearch: searchText) { (album, count) in
                if let album = album {
                    self.itemsAlbumsArray += album
                } else {
                     errorHandler?()
                }
                if count == 0 {
                    errorHandler?()
                }
            }
        }
    }
}
// MARK: - show and go through the collection
extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsAlbumsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "albumCell", for: indexPath) as? AlbumCollectionViewCell {
            itemCell.album = itemsAlbumsArray[indexPath.row]
            activityIndicatorSearch.stopAnimating()
            return itemCell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let album = itemsAlbumsArray[indexPath.row]
        self.performSegue(withIdentifier: "showResultAlbum", sender: album)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultAlbum" {
            if let resultVC = segue.destination as? ResultViewController {
                let album = sender as? AlbumResult
                resultVC.album = album
            }
        }
    }
}
// MARK: - action by clicking on searchBar
extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        activityIndicatorSearch.startAnimating()
        itemsAlbumsArray.removeAll()
        makeNetworkRequest {
            // alert for invalid data
            let alert = UIAlertController(title: "Error", message: "Your search for nothing was found.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.searchBarAlbums.text = ""
            self.activityIndicatorSearch.stopAnimating()
        }
        collectionView.reloadData()
        view.endEditing(true)
    }
	// MARK: - clean by clicking on Cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        itemsAlbumsArray.removeAll()
        collectionView.reloadData()
        searchBarAlbums.text = ""
    }
}
