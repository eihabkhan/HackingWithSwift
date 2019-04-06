//
//  Person.swift
//  Project 10
//
//  Created by Eihab Khan on 3/18/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
