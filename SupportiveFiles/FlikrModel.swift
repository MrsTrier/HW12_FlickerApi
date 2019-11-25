//
//  FlikrModel.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

enum Flickr {
    
    enum ImageModel {
        struct Request {
            var requestWord: String
            var page: Int
        }
        struct Response {
            var images: [Images]
        }
        struct ViewModel {
            var images: [Images]
        }
    }
}
