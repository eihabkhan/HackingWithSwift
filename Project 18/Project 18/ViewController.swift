//
//  ViewController.swift
//  Project 18
//
//  Created by Eihab Khan on 4/6/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(1,2,3,4,5,6, separator: "-")
        print("A message", terminator: " ")
        print("Another message", terminator: "\n")
        print("Yet another message", terminator: " ")
        
        assert(1 == 1, "Math Error")
//        assert(1 == 2, "Math Error")
        
        for i in 1...100 {
            print("Number: \(i)")
        }
    }


}

