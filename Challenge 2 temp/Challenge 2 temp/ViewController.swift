//
//  ViewController.swift
//  Challenge 2 temp
//
//  Created by Eihab Khan on 3/6/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForItem))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        navigationItem.rightBarButtonItems = [addButton,shareButton]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear List", style: .plain, target: self, action: #selector(clearShoppingList))
        
    }
    
    @objc func share() {
        let ac = UIActivityViewController(activityItems: [shoppingList.joined(separator: "\n")], applicationActivities: nil)
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?[1]
        present(ac, animated: true)
    }
    
    @objc func promptForItem() {
        let ac = UIAlertController(title: "Add New Item", message: "Add new item to shopping list", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Add Item", style: .default) {
            [weak self, weak ac] _ in
            guard let itemToAdd = ac?.textFields?[0].text?.lowercased() else { return }
            if !itemToAdd.isEmpty {
                self?.add(item: itemToAdd)
            }
        })
        present(ac, animated: true)
    }
    
    func add(item: String) {
        shoppingList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearShoppingList() {
        shoppingList = []
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }

}

