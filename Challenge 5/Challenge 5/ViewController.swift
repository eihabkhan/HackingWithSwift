//
//  ViewController.swift
//  Challenge 5
//
//  Created by Eihab Khan on 4/1/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {

    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(fetchCountries), with: nil)
    }
    
    @objc func fetchCountries() {
        let urlString = "https://restcountries.eu/rest/v2/all?fields=name;capital;population;region;callingCodes;subregion;nativeName"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                print("Data fetched: \(data)")
                parse(data)
            }
        }
    }
    
    func parse(_ data: Data) {
        let decoder = JSONDecoder()
        if let parsedData = try? decoder.decode([Country].self, from: data) {
            countries = parsedData
            tableView.reloadData()
            }
        }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detaiTableViewController = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            detaiTableViewController.country = countries[indexPath.row]
            navigationController?.pushViewController(detaiTableViewController, animated: true)
        }
    }
    


}

