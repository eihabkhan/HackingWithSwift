//
//  DetailViewController.swift
//  Project 1
//
//  Created by Eihab Khan on 2/21/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    var selectedImage: String?
    var imagePos: Int?
    var total: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imagePosition = imagePos,
            let totalNumberOfImages = total {
            title = "Picture \(imagePosition) of \(totalNumberOfImages)"
        }
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
   

}
