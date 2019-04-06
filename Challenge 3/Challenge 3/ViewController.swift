//
//  ViewController.swift
//  Challenge 3
//
//  Created by Eihab Khan on 3/17/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var livesLabel: UILabel!
    @IBOutlet var hangmanImage: UIImageView!
    @IBOutlet var wordLabel: UILabel!
    
    var allWords = [String]()
    var guessesLeft = 7 {
        didSet {
            hangmanImage.image = UIImage(named: "\(guessesLeft)")
            livesLabel.text = "Guesses Left: \(guessesLeft)"
        }
    }
    var usedLetters = [String]()
    var word = ""
    var promptWord = "" {
        didSet {
            wordLabel.text = promptWord
        }
    }
    var activatedButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newGame(_:)))
        
        if let wordsURL = Bundle.main.url(forResource: "words", withExtension: "txt") {
            if let words = try? String(contentsOf: wordsURL) {
                allWords = words.components(separatedBy: "\n")
            }
        }
        
        newGame()
        
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
            guard let buttonTitle = sender.titleLabel?.text?.lowercased() else { return }
            usedLetters.append(buttonTitle)
            promptWord = ""
            
            if !word.contains(buttonTitle) {
                guessesLeft -= 1
                
            }
            
            for letter in word {
                let letterString = String(letter)
                
                if usedLetters.contains(letterString) {
                    promptWord += letterString
                } else {
                    promptWord += "?"
                }
            }
            
            activatedButtons.append(sender)
            sender.isEnabled = false
            
            if promptWord == word {
                promptGameFinish(title: "You Saved Me", message: "Game Complete!")
            } else if guessesLeft == 0 {
                 promptGameFinish(title: "I'm Dead!!", message: "Game Over")
            }
        
    }
    
    func promptGameFinish(title: String, message: String) {
        let ac = UIAlertController(title: title, message:  message , preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Play Again", style: .default, handler: newGame))
        present(ac, animated: true)
    }
        
    @objc func newGame(_ action: UIAlertAction? = nil) {
        promptWord = ""
        usedLetters = []
        guessesLeft = 7
        
        word = allWords.shuffled()[0].lowercased()
        
        for _ in word {
            promptWord += "?"
        }
        
        for button in activatedButtons {
            button.isEnabled = true
        }
    }
    
    
}
