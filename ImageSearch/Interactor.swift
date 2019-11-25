//
//  Interactor.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

class Interactor {
    
    var presenter: Presenter?
    var worker: Worker? // Class which creates session and sends tasks on server
    var images = [Images]() // Array of images with descriptions
    var picturesToDisplay = [Content]() { // массив с url
        didSet {
            loadImages() // Whenever Content structure is updated - load new images
        }
    }
    
    /// Загружаем данные с api
    func loadImagesData(request: Flickr.ImageModel.Request) {
        loadImageList(by: request.requestWord, at: request.page) { arrayOfContent in
            if request.page == 1 {
                self.images.removeAll() // Clean up table to display result of new search
            }
            self.picturesToDisplay = arrayOfContent
        }
    }
    
    /// Loads images and sends to presenter
    private func loadImages() {
        let group = DispatchGroup()
        for content in self.picturesToDisplay {
            group.enter()
            self.loadImage(at: content.url) { image in
                guard let image = image else {
                    group.leave()
                    return
                }
                let viewModel = Images(description: content.description, image: image)
                self.images.append(viewModel)
                group.leave()
            }
        }
        group.notify(queue: .main) {
            let response = Flickr.ImageModel.Response(images: self.images)
            self.presenter?.presentImage(response: response)
        }
    }
    
    /// Requesting to flickr
    ///
    /// - Parameters:
    ///   - keyWord - word to find images
    ///   - page - page count
    private func loadImageList(by keyWord: String, at page: Int = 1, completion: @escaping([Content]) -> Void) {
        let url = API.searchPath(text: keyWord, extras: "url_m", page: page)
        worker?.getData(at: url) { data in
            guard let data = data else {
                completion([])
                return
            }
            
            let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: .init()) as? Dictionary<String, Any>
            
            guard let notNilResponse = jsonResponse, let photos = notNilResponse["photos"] as? Dictionary<String, Any>,
                let photosArray = photos["photo"] as? [[String: Any]] else { return }
            
            let content = photosArray.map { (item) -> Content in
                let url = item["url_m"] as? String ?? ""
                let title = item["title"] as? String ?? ""
                return Content(url: url, description: title)
            }
            completion(content)
        }
    }
    
    /// Images loading
    private func loadImage(at path: String, completion: @escaping (UIImage?) -> Void) {
        worker?.getData(at: path) { data in
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
    }
    
}
