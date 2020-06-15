//
//  ViewController.swift
//  Consolidation 2
//
//  Created by Vyacheslav Pronin on 13/06/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var countries = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    navigationController?.navigationBar.prefersLargeTitles = true
        
        title = "Country"
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        countries.sort()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Countries", for: indexPath)
        cell.textLabel?.text = countries[indexPath.row].capitalized
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            

            vc.selectedImage = countries[indexPath.row]

            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

