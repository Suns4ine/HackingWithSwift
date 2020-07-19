//
//  ViewController.swift
//  Consolidation 3
//
//  Created by Vyacheslav Pronin on 19/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(purchases))
        
       startApp()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    func startApp()
    {
        title = "My purchases: \(shoppingList.count)"
        shoppingList.removeAll()
        tableView.reloadData()
        
        print(1)/////////////////
    }
    
    @objc   func purchases() {
        let ac = UIAlertController(title: "Enter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let product = ac?.textFields?[0].text else { return }
            self?.submit(product)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(_ product: String) {
        
        shoppingList.insert(product, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }
}

