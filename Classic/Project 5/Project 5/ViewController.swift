//
//  ViewController.swift
//  Project 5
//
//  Created by Vyacheslav Pronin on 02/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var allWords = [String]()
    var usedWords = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Game", style: .plain, target: self, action: #selector(startGame))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        }

        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        
        startGame()
        
    }
    
    @objc func startGame() {
        title = allWords.randomElement()
        usedWords.removeAll(keepingCapacity: true)
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
    
    @objc func promptForAnswer() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }

        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()


        if isPossible(word: lowerAnswer) {
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    for word in usedWords {
                    
                        if answer.lowercased() == word.lowercased() {
                            showErrorMessage(error: "isOriginal")
                            return
                        }
                    }
                    
                    usedWords.insert(answer, at: 0)

                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                } else {
                    showErrorMessage(error: "isReal")
                }
            } else {
                showErrorMessage(error: "isOriginal")
            }
        } else {
            showErrorMessage(error: "isPossible")
        }
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else { return false }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }

    func isOriginal(word: String) -> Bool {
        return !usedWords.contains(word)
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        var testWord: String = ""

        for char in word {
            var i = 0
            
            if i == 3 {
                break
            }
            testWord.append(char)
            i += 1
        }
        
        if word.count == 3 || (title?.hasPrefix(testWord) ?? true && word.count == 3) {
            return false
        }
        return misspelledRange.location == NSNotFound
    }
    
    func showErrorMessage(error: String) {
        let errorTitle: String
        let errorMessage: String
        
        switch error {
        case "isReal":
            errorTitle = "Word not recognised"
            errorMessage = "You can't just make them up, you know!"
        case "isOriginal":
            errorTitle = "Word used already"
            errorMessage = "Be more original!"
        case "isPossible":
            guard let title = title?.lowercased() else { return }
            
            errorTitle = "Word not possible"
            errorMessage = " You can't spell that word rom \(title)"
        default:
            errorTitle = "Error"
            errorMessage = "Error not found"
        }
        
        let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }

}

