//
//  DetailViewController.swift
//  Project 7
//
//  Created by Eihab Khan on 3/9/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView : WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let detailItem = detailItem else { return }
        let html = """
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <meta http-equiv="X-UA-Compatible" content="ie=edge">
                <style>
                    body { font-size: 150%; }
                    h1 { font-size: 160% }
                </style>
            <title>\(detailItem.title)</title>
            </head>
            <body>
                <h1>
                    \(detailItem.title)
                </h1>
                \(detailItem.body)
            </body>
        </html>
        """
        webView.loadHTMLString(html, baseURL: nil)
    }


}
