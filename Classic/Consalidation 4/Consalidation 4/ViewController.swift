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
    var helpButton: UIButton!
    
    var arrayWord = [String]()
    var useChar = [String]()
    var checkSymbol = ""
    var promtWord = ""
    var word = ""
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
        textButton.addTarget(self, action: #selector(charTapped), for: .touchUpInside)
        view.addSubview(textButton)
        
        newGameButton = UIButton(type: .system)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.addTarget(self, action: #selector(newTapped), for: .touchUpInside)
        view.addSubview(newGameButton)
        
        helpButton = UIButton(type: .system)
        helpButton.translatesAutoresizingMaskIntoConstraints = false
        helpButton.setTitle("Help", for: .normal)
        helpButton.addTarget(self, action: #selector(helpTapped), for: .touchUpInside)
        view.addSubview(helpButton)
        
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
            newGameButton.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 30),
            
            helpButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            helpButton.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -30)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(loadWord), with: nil)
    }
    
    @objc func charTapped(_ sender: UIButton) {
         var charred = ""
         let ac = UIAlertController(title: "Enter", message: nil, preferredStyle: .alert)
         ac.addTextField()
         
         let submitChar = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac]  _ in
            guard let product = ac?.textFields?[0].text else { return }
            charred = self?.clearTab(product) ?? ""
            
             if charred.isEmpty { return }
            
             self?.checkSymbol = charred
             self?.useChar.append(charred)
             self?.checkWord()
         }
         
         ac.addAction(submitChar)
         ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
         
         present(ac, animated: true)
         
    }
    
    @objc func newTapped(_ sender: UIButton) {
        newGame()
    }
    
    @objc func helpTapped(_ sender: UIButton) {
        
        let ac = UIAlertController(title: "Carefully", message: "The hint gives a letter but takes 2 points away.\nIf you have 2 or less points, then don't use it.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self] _ in
            self?.help()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
        
    }
    
    @objc func loadWord() {
        
        if let wordFileURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let wordContent = try? String(contentsOf: wordFileURL) {
                arrayWord = wordContent.components(separatedBy: "\n")
            }
        }
        
        if arrayWord.isEmpty {
            arrayWord = ["unknow"]
            return
        }
        
        self.useWord()
    }
    
    func useWord() {
        word = arrayWord.randomElement()!.lowercased()
        
        for _ in 0..<word.count {
            promtWord += "?"
        }
        
        DispatchQueue.main.async {
            self.printWord()
        }
    }
    
    @objc func checkWord() {
        
        var flag = 0
        promtWord = ""
        
        for letter in word {
            let strLetter = String(letter)

            if useChar.contains(strLetter) {
                promtWord += strLetter
            } else {
                promtWord += "?"
            }
            
            if letter == Character(checkSymbol) {
                flag = 1
            }
        }
        
        checkSymbol = ""
        
        checkFlag(flag)
        printWord()
    }
    
    @objc func printWord() {
        wordLabel.text = promtWord
        
        if promtWord == word {
            let ac = UIAlertController(title: "WIN", message: "You won!!!\nDo you want to play more?", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Yes", style: .default) { [weak self] _ in
                self?.newGame()
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            present(ac, animated: true)
        }
    }
    
    func newGame() {
        textButton.isEnabled = true
        useChar.removeAll()
        checkSymbol = ""
        promtWord = ""
        point = 10
        useWord()
        
    }
    
    func checkFlag(_ flag: Int) {
        
        switch flag {
        case 1:
            return
        case 2:
            break
        default:
            point -= 1
        }
        
        
        if point <= 0 {
            let ac = UIAlertController(title: "Lose", message: "This word is \(word)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            textButton.isEnabled = false
            
            present(ac, animated: true)
        }
    }
    
    func clearTab(_ word: String) -> String {
        var slow = word.replacingOccurrences(of: " ", with: "")
        if slow.isEmpty { return "" }
        slow = String(slow[slow.startIndex]).lowercased()
        return slow
    }

    func help() {
        point -= 2
        
        if point <= 0 {
            checkFlag(2)
        }
        
        for letter in word {
            let strLetter = String(letter)
            
                if !useChar.contains(strLetter) {
                    checkSymbol = String(letter)
                    useChar.append(checkSymbol)
                     break
            }
        }
         checkWord()
        
    }
}

