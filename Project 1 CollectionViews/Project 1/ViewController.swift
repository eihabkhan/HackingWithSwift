//
//  ViewController.swift
//  Project 1
//
//  Created by Eihab Khan on 2/20/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let items = try! fm.contentsOfDirectory(atPath: path).sorted()
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(Picture(name: item))
            }
        }
//
//        DispatchQueue.global(qos: .userInteractive).async {
//            [weak self] in
//
//
//        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Picture", for: indexPath) as? PictureCollectionViewCell else { fatalError("Unable to dequeue cell") }
        cell.imageView.image = UIImage(named: pictures[indexPath.item].name)
        cell.label.text = pictures[indexPath.item].name

        cell.imageView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.selectedImage = pictures[indexPath.row].name
            detailViewController.imagePos = indexPath.row + 1
            detailViewController.total = pictures.count
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
    
    @IBAction func recommendButtonTapped(_ sender: UIBarButtonItem) {
        let vc = UIActivityViewController(activityItems: [URL(string: "https://itunes.apple.com/ae/app/twitter/id333903271?mt=8")!], applicationActivities:  nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    

}

