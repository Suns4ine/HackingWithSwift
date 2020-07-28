//
//  ViewController.swift
//  Consalidation 4
//
//  Created by Vyacheslav Pronin on 27/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var lifeLabel: UILabel!
    var wordLabel: UILabel!
    var textButton: UIButton!
    var newGameButton: UIButton!
    
    var point = 10 {
        didSet {
            lifeLabel.text = "Your point to life: \(point)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIView()
        view.backgroundColor = .white
        
        lifeLabel = UILabel()
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        lifeLabel.text = "Your point to life: \(point)"
        view.addSubview(lifeLabel)
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.text = "***"
        view.addSubview(wordLabel)
        
        textButton = UIButton(type: .system)
        textButton.translatesAutoresizingMaskIntoConstraints = false
        textButton.setTitle("submit", for: .normal)
        view.addSubview(textButton)
        
        newGameButton = UIButton(type: .system)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitle("New Game", for: .normal)
        view.addSubview(newGameButton)
        
        NSLayoutConstraint.activate([
            lifeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            wordLabel.topAnchor.constraint(equalTo: lifeLabel.topAnchor, constant: 40),
            textButton.topAnchor.constraint(equalTo: wordLabel.topAnchor, constant: 40),
            newGameButton.topAnchor.constraint(equalTo: textButton.topAnchor, constant: 40)
        ])
        // Do any additional setup after loading the view.
    }


}

