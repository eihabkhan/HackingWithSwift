//
//  Picture.swift
//  Challenge 4
//
//  Created by Eihab Khan on 3/24/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import Foundation

class Picture: NSObject, NSCoding {
    var image: String
    var caption: String
    
    required init?(coder aDecoder: NSCoder) {
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
        caption  = aDecoder.decodeObject(forKey: "caption") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(image, forKey: "image")
        aCoder.encode(caption, forKey: "caption")
    }
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
