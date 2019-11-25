//
//  Assembler.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import Foundation

class Assembler {
    
    func setup(viewController: ViewController) {
        let worker = Worker()
        let interactor = Interactor()
        let presenter = Presenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        interactor.worker = worker
    }
    
}
