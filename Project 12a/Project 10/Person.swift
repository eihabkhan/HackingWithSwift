//
//  Person.swift
//  Project 10
//
//  Created by Eihab Khan on 3/18/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    var name: String
    var image: String
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
