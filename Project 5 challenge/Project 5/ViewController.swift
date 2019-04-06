//
//  ViewController.swift
//  Project 5
//
//  Created by Eihab Khan on 3/2/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        startGame()
    }
    
    @objc func promptForAnswer() {
        
        // 1- create the alert controller
        // 2- add the text field
        // 3- add the submit button and handling code
        // 4- attach the action to alert controller
        // 5- present the alert controller
        
        let ac = UIAlertController(title: "Enter Answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text?.lowercased() else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer: String) {
  
        if isUnique(word: answer) {
            if isPossible(word: answer) {
                if isOriginal(word: answer) {
                    if isReal(word: answer) {
                        usedWords.insert(answer, at: 0)
                        let indexPath = IndexPath(row: 0, section: 0)
                        tableView.insertRows(at: [indexPath], with: .automatic)
                        save()
                        return
                    } else {
                        showErrorMessage(title: "Word not recognized", message: "You can't just make them up you know.")
                    }
                } else {
                    showErrorMessage(title: "Word already used", message: "Be more original!")

                }
            } else {
                showErrorMessage(title: "Word not possible", message: "You can't spell that word from '\(title!.lowercased())'")
            }
        } else {
            showErrorMessage(title: "Word is reserved", message: "Be more creative!")
        }
    }
    
    func showErrorMessage(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        for letter in word {
            if let possition = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: possition)
            } else {
                return false
            }
        }
        return true
    }
    
    func isUnique(word: String) -> Bool {
        return !(word == title!)
    }
    
    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool {
        
        if word.count < 3 {
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    
    func save() {
        let defaults = UserDefaults.standard
        defaults.set(usedWords, forKey: "usedWords")
        defaults.set(title, forKey: "lastWord")
    }

    @objc func startGame() {
        let defaults = UserDefaults.standard
        title = defaults.string(forKey: "lastWord") ?? allWords.randomElement()
//        usedWords.removeAll(keepingCapacity: true)
        usedWords = defaults.array(forKey: "usedWords") as? [String] ?? []
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

}

