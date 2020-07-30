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
    
    var arrayWord = [String]()
    var useChar = [String]()
    var word = ""
    var promtWord = ""
    var point = 10 {
        didSet {
            lifeLabel.text = "Your point to life: \(point)"
        }
    }
    

    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .black
        
        lifeLabel = UILabel()
        lifeLabel.translatesAutoresizingMaskIntoConstraints = false
        lifeLabel.textColor = .white
        lifeLabel.text = "Your point to life: \(point)"
        view.addSubview(lifeLabel)
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textColor = .white
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
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadWord), with: nil)
    }

    @objc func loadWord() {
        
        if let wordFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let wordContent = try? String(contentsOf: wordFileURL) {
                arrayWord = wordContent.components(separatedBy: "\n")
            } else {
                let ac = UIAlertController(title: "Ooops.....", message: "We were unable to download the words from the file.", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                
                present(ac, animated: true)
            }
        }
        
        if arrayWord.isEmpty {
            arrayWord = ["unknow"]
            return
        }
        
        useWord()
        
    }
    
    func useWord() {
        word = arrayWord.randomElement() ?? "what"
        
        performSelector(onMainThread: #selector(checkWord), with: nil, waitUntilDone: false)
    }
    
    @objc func checkWord() {
        
        var flag = 0
        
        for letter in word {
            let strLetter = String(letter)

            if useChar.contains(strLetter) {
                promtWord += strLetter
                flag = 1
            } else {
                promtWord += "?"
            }
        }
        
        checkFlag(flag)
        
        printWord()
    }
    
    @objc func printWord() {
        wordLabel.text = promtWord
        
        if promtWord == word {
            let ac = UIAlertController(title: "WIN", message: "You won!!!\nDo you want to play more?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(ac, animated: true)
        }
    }
    
    func newGame() {
        
    }
    
    func checkFlag(_ flag: Int) {
        
        if flag == 1 {
            return
        } else {
            point -= 1
        }
        
        if point == 0 {
            let ac = UIAlertController(title: "Lose", message: "You lose", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            
            present(ac, animated: true)
        }
    }

}

