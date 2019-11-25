//
//  SessionFactory.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

class SessionFactory {
    func createDefaultSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }
}
