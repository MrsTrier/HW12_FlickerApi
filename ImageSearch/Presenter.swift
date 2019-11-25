//
//  Presenter.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

class Presenter {
    weak var viewController: ViewController?
    
    /// Displays loaded images on viewController
    func presentImage(response: Flickr.ImageModel.Response) {
        let viewModel = Flickr.ImageModel.ViewModel(images: response.images)
        viewController?.displayImages(viewModel: viewModel)
    }
    
}
