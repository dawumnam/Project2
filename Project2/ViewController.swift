//
//  ViewController.swift
//  Project2
//
//  Created by dawum nam on 4/28/21.
//

import UIKit

class ViewController: UIViewController {
    
    var highestScore: Int!
    var isHighestAlertedAlready: Bool = false


    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(updateScore))
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        let defaults = UserDefaults.standard
        highestScore = defaults.integer(forKey: "highestScore")
     
        askQuestion()

        // Do any additional setup after loading the view.
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.tag = 0
        button2.tag = 1
        button3.tag = 2
        
        button1.layer.borderColor = UIColor.darkGray.cgColor

    }
    
    func askQuestion (action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = countries[correctAnswer].uppercased()

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "Corret"
            score+=1
            setHighestScoreAndAlert()
            
        } else {
            title = "Wrong"
            score-=1
        }
        print(sender.tag)
        let ac = UIAlertController(title: title, message: "Your score is \(score).",preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
    
    @objc func updateScore() {
        let vc = UIAlertController(title: "Score", message: String(score), preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default))
        present(vc, animated: true)
    }
    
    func setHighestScoreAndAlert() {
        if score > highestScore {
            highestScore = score
            if !isHighestAlertedAlready {
                isHighestAlertedAlready.toggle()
                let ac = UIAlertController(title: "New Record!", message: "Congratulations! Your score \(highestScore!) is new record!", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .default))
                present(ac, animated: true)
            }
            let defaults = UserDefaults.standard
            defaults.set(highestScore, forKey: "highestScore")
        }
    }
    
}

