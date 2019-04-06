//
//  ViewController.swift
//  Challenge 2
//
//  Created by Eihab Khan on 3/6/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingCart = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear List", style: .plain, target: self, action: #selector(clearList))
        
    }
    
    @objc func clearList() {
        shoppingCart = []
        tableView.reloadData()
    }
    
    @objc func promptForItem() {
        let ac = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addButton = UIAlertAction(title: "Add Item", style: .default) {
            [weak self, weak ac] _ in
            
            guard let item = ac?.textFields?.first?.text?.lowercased() else { return }
            self?.add(item)
        }
        ac.addAction(addButton)
        present(ac, animated: true)
    }
    
    func add(_ item: String) {
        if isNew(item: item) {
            shoppingCart.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
            return
        } else {
            showErrorMessage(withTitle: "Item already in cart", andMessage: "The item already exists in the shopping cart")
        }
    }
    
    func showErrorMessage(withTitle title: String, andMessage message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }

    func isNew(item: String) -> Bool {
        return !shoppingCart.contains(item)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingCart[indexPath.row]
        return cell
    }

}

