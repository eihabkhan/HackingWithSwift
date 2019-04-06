//
//  DetailViewController.swift
//  Challenge 4
//
//  Created by Eihab Khan on 3/24/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var picture: Picture!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.hidesBarsOnTap = true
        title = picture.caption
        let path = getDocumentsDirectory().appendingPathComponent(picture.image)
        imageView.image = UIImage(contentsOfFile: path.path)
        
    }
    

    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

}
