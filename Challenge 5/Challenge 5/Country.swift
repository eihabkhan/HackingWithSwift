//
//  Country.swift
//  Challenge 5
//
//  Created by Eihab Khan on 4/1/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import Foundation

struct Country: Codable {
    var name: String
    var capital: String
    var population: Int
    var region: String
    var callingCodes: [String]
    var subregion: String
    var nativeName: String
}
