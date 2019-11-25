//
//  ZoomScreen.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

class ZoomScreen: UIViewController {

    
    var imageToDisplay: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupUI()
    }
    
    private func setupUI() {
        let imageView = UIImageView(image: imageToDisplay)
        let screenWidth = view.frame.size.width
        let screenHeight = view.frame.size.height
        
        imageView.frame = CGRect(x: 0, y: 0 , width: screenWidth, height: screenHeight)
        view.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.contentMode = .center
        
        view.addSubview(imageView)
    
    }
    
    convenience init() {
        self.init(nil)
    }
    
    init(_ image: UIImage?) {
        super.init(nibName: nil, bundle: nil)
        self.imageToDisplay = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
