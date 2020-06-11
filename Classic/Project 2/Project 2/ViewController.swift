//
//  ViewController.swift
//  Project 2
//
//  Created by Vyacheslav Pronin on 08/06/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var scoreTitle: UILabel!
    
    
    var countries = [String]()
    var correctAnswer = Int.random(in: 0...2)
    var score: Int = 0 {
        didSet {
        scoreTitle.text = "Score: \(score)"
        }
    }
    var result = 0
    var textBanner = ""
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        // Do any additional setup after loading the view.
        askQuestion()
    }
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        title = countries[correctAnswer].uppercased()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            correctAnswer = .random(in: 0...2)
            textBanner = "Your score is \(score)."
        } else {
            title = "Oops"
            score -= 1
            textBanner = "maybe this is a \(countries[sender.tag].capitalized)"
        }
        result += 1
        
        if (result == 10) {

            let final = UIAlertController(title: "The end", message: "Your result is \(score) out of 10", preferredStyle: .alert)
            final.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(final, animated: true)
            result = 0
            score = 0
            
        } else {
            let ac = UIAlertController(title: title, message: textBanner, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
    }
    //    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }


}

