//
//  ViewController.swift
//  Project 1
//
//  Created by Eihab Khan on 2/20/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        DispatchQueue.global(qos: .userInteractive).async {
            [weak self] in
            let items = try! fm.contentsOfDirectory(atPath: path).sorted()
            for item in items {
                if item.hasPrefix("nssl") {
                    self?.pictures.append(item)
                }
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailViewController.selectedImage = pictures[indexPath.row]
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

