//
//  ViewController.swift
//  Consolidation 3
//
//  Created by Vyacheslav Pronin on 19/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var selctedString: String?
    var shoppingList = [String]() {
        didSet {
            title = "My purchases: \(shoppingList.count)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(startApp))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMyPurchases)), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(purchases))]
        
       startApp()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Delete", message: "Do you want to delete \(shoppingList[indexPath.row])?", preferredStyle: .alert)
        let submitYes = UIAlertAction(title: "Yes", style: .destructive) {  _ in
            self.remove(indexPath.row)
        }
        let submitCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        ac.addAction(submitCancel)
        ac.addAction(submitYes)
        present(ac, animated: true)
        
    }
    
    @objc func shareMyPurchases() {
        var text = "My shopping list:\n"
        
        text += shoppingList.joined(separator: "\n")

        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func startApp()
    {
        title = "My purchases: \(shoppingList.count)"
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc   func purchases() {
        let ac = UIAlertController(title: "Enter", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] action in
            guard let product = ac?.textFields?[0].text else { return }
            let testProbel: String = product.replacingOccurrences(of: " ", with: "")
            
            if testProbel.isEmpty {
                return
            }
            
            self?.submit(product)
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    func submit(_ product: String) {
        
        shoppingList.insert(product, at: 0)
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        return
    }
    
    func remove(_ product: Int) {
        shoppingList.remove(at: product)
        let indexPath = IndexPath(row: product, section: 0)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        return
    }
}

