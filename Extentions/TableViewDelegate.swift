//
//  TableViewDelegate.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row // Check if it is the last loaded row
        if lastRow == images.count - 1, images.count > 17 {
            loadingIndicator.startAnimating()
            loadNextPage()
        }
    }
    
    // New page loading
    private func loadNextPage() {
        page += 1
        let request = Flickr.ImageModel.Request(requestWord: keyWord, page: page)
        interactor?.loadImagesData(request: request)
    }
    
}
