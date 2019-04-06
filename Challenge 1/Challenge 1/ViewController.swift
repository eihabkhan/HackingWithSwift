//
//  ViewController.swift
//  Challenge 1
//
//  Created by Eihab Khan on 2/28/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var flags = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting Flags From App Bundle    
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let countries = try! fm.contentsOfDirectory(atPath: path)
        
        for flag in countries where flag.contains("png") {
            flags.append(flag)
        }
        print(flags)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Flag", for: indexPath)
        cell.textLabel?.text = flags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detailVC.selectedImage = flags[indexPath.row]
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }


}

