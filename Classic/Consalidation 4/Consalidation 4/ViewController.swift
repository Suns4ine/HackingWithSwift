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
            lifeLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 5),
            lifeLabel.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 15),
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //wordLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            wordLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 1),
            wordLabel.heightAnchor.constraint(equalToConstant: 200),
            //wordLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.layoutMarginsGuide.topAnchor, multiplier: 20),
            textButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textButton.topAnchor.constraint(equalToSystemSpacingBelow: wordLabel.bottomAnchor, multiplier: 2),
            newGameButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            newGameButton.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 30)
        ])
        // Do any additional setup after loading the view.
    }


}

