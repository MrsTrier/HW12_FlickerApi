//
//  ViewController.swift
//  ImageSearch
//
//  Created by Roman Cheremin on 25/11/2019.
//  Copyright © 2019 Daria Cheremina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let tableView = UITableView()
    var loadingIndicator = UIActivityIndicatorView(style: .gray)
    var keyWord = ""
    var page = 1
    var interactor: Interactor?
    var images = [Images]()
    
    let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.isSuspended = true
        queue.maxConcurrentOperationCount = 1
        queue.name = "com.OperationQueue"
        return queue
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupUI()
    }
    
    
    // MARK: - setup UI
    private func setupUI() {
        let textField = UITextField()
        let textFieldHeight: CGFloat = 50
        let centeredParagraphStyle = NSMutableParagraphStyle()
        let attributedPlaceholder = NSAttributedString(string: "👀 Я ищу...", attributes: [NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        
        self.title = "Flicker search"
        view.backgroundColor = .white
        loadingIndicator.center = view.center

        textField.frame = CGRect(x: 20, y: 100, width: view.frame.width - 60, height: textFieldHeight)
        textField.backgroundColor = .white
        centeredParagraphStyle.alignment = .center
        textField.attributedPlaceholder = attributedPlaceholder
        
        tableView.frame = CGRect(x: 0,
                                 y: textField.frame.maxY,
                                 width: view.frame.width,
                                 height: view.frame.height - textFieldHeight)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
            
        textField.addTarget(self, action: #selector(textDidChanged), for: .editingChanged)
        
        view.addSubview(tableView)
        view.addSubview(textField)
        view.addSubview(loadingIndicator)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var screenWithImage = ZoomScreen(tableView.cellForRow(at: indexPath)?.imageView?.image)
        
        navigationController?.pushViewController(screenWithImage, animated: true)
    }
    
    
    /// Request to load images for interactor
    ///
    /// - Parameter requestWord: word to find
    private func loadImages(by requestWord: String) {
        let request = Flickr.ImageModel.Request(requestWord: keyWord, page: 1)
        interactor?.loadImagesData(request: request)
    }
    
    func displayImages(viewModel: Flickr.ImageModel.ViewModel) {
        images = viewModel.images
        loadingIndicator.stopAnimating()
        tableView.reloadData()
    }
    
    /// Loading of images by key word and loadingIndicator's animation is starting after delay
    /// textField.text force unwraped because, textDidChanged - selector called only new text is in the textField
    ///
    /// - Parameter textField - UITextField
    @objc private func textDidChanged(_ textField: UITextField) {
        operationQueue.isSuspended = true // Operations are not scheduled for execution until this property is true
        operationQueue.cancelAllOperations()
        guard (textField.text != nil) else {
            return
        }
        keyWord = textField.text!
        operationQueue.addOperation {
            self.loadImages(by: self.keyWord)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadingIndicator.startAnimating()
            self.operationQueue.isSuspended = false
        }
    }
}
