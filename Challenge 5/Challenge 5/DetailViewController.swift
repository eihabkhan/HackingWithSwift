//
//  DetailViewController.swift
//  Challenge 5
//
//  Created by Eihab Khan on 4/2/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    var country: Country!
    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var populationLabel: UILabel!
    @IBOutlet var regionLabel: UILabel!
    @IBOutlet var subregionLabel: UILabel!
    @IBOutlet var callingCodesLabel: UILabel!
    @IBOutlet var nativeNameLabel: UILabel!
    @IBOutlet var flagImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = country.name
        capitalLabel.text = country.capital
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formattedPopulation = formatter.string(from: NSNumber(value: country.population))
        populationLabel.text = formattedPopulation
        regionLabel.text = country.region
        subregionLabel.text = country.subregion
        callingCodesLabel.text = "+\(country.callingCodes.first!)"
        nativeNameLabel.text = country.nativeName
        
        flagImageView.image = UIImage(named: country.name.replacingOccurrences(of: " ", with: "-").lowercased())
    }
    
    
}
