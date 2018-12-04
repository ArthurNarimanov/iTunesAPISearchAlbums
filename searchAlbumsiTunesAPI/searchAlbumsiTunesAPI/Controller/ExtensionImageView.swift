//
//  ExtensionImageView.swift
//  searchAlbumsiTunesAPI
//
//  Created by Arthur Narimanov on 03/12/2018.
//  Copyright © 2018 Arthur Narimanov. All rights reserved.
//

import UIKit
// MARK: - extension imageView for  getting image by URL 
extension UIImageView {
    func downloaded(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                // if don't image
                else { return } // self.image = UIImage(named: "") }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url)
    }
}
