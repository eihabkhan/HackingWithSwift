//
//  ViewController.swift
//  Project 2
//
//  Created by Eihab Khan on 2/22/19.
//  Copyright © 2019 Eihab Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var newGameButton: UIBarButtonItem!
    
    // MARK: Variables
    var countries = [String]()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
            if score != 0 {
                newGameButton.isEnabled = true
            }
        }
    }
    var correctAnswer = 0
    var questionsAsked = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland",
                      "italy", "monaco", "nigeria", "poland",
                      "russia", "spain" ,"uk", "us"]
        askQuestion()
    }

    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased()
        questionsAsked += 1
    }
    
    // MARK: Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 4, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (finished) in
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        
        var title: String
        var alert = ""
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            alert = "\n (You chose \(countries[sender.tag].uppercased()))"
            score -= 1
        }
        if questionsAsked <= 10 {
            let alertController = UIAlertController(title: title, message: "Your score is \(score) \(alert)", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(alertController, animated: true)
        } else {
            askQuestion()
        }
    }
    

    @IBAction func newGameButtonTapped(_ sender: UIBarButtonItem) {
        score = 0
        questionsAsked = 0
        askQuestion()
        newGameButton.isEnabled = false
    }
    
    @IBAction func scoreButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Score", message: "Your score is: \(score)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    

    
    
}

