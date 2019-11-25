//
//  Worker.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

/// Loading data from server
class Worker {
    let session: URLSession
    
    init() {
        self.session = SessionFactory().createDefaultSession()
    }
    
    func getData(at path: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: path) else {
            completion(nil)
            return
        }
        let dataTask = session.dataTask(with: url) { data, _, _ in
            completion(data)
        }
        dataTask.resume()
    }
    
    func getData(at url: URL, completion: @escaping (Data?) -> Void) {
        let dataTask = session.dataTask(with: url) { data, _, _ in
            completion(data)
        }
        dataTask.resume()
    }
    
}
