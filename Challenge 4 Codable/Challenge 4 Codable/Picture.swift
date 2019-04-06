//
//  Picture.swift
//  Challenge 4 Codable
//
//  Created by Eihab Khan on 3/25/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import Foundation

class Picture: Codable {
    var image: String
    var caption: String
    
    init(image: String, caption: String) {
        self.image = image
        self.caption = caption
    }
}
