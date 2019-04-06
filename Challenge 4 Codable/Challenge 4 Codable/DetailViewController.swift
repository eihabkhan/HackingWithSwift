//
//  DetailViewController.swift
//  Challenge 4 Codable
//
//  Created by Eihab Khan on 3/25/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var picture: Picture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnTap = true
        
        title = picture.caption
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(picture.image)
        imageView.image = UIImage(contentsOfFile: path.path)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
