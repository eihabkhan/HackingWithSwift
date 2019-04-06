//
//  DetailViewController.swift
//  Project 16
//
//  Created by Eihab Khan on 4/3/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    
    var selectedCity: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        
        view = webView
        
        title = selectedCity
        
        let urlString = "https://en.wikipedia.org/wiki/\(selectedCity!)"
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        webView.load(urlRequest)
    }

}
