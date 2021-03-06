//
//  ViewController.swift
//  Project 1
//
//  Created by Vyacheslav Pronin on 11/05/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var pictures = [String]()
    var cells = [Cell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        performSelector(inBackground: #selector(addPicture), with: nil)

        
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row] //pictures[indexPath.row]
            vc.namePicture = String(pictures.index(after: indexPath.row))
            vc.maxArrayPicture = String(pictures.count)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addPicture() {
        let fm = FileManager.default
             let path = Bundle.main.resourcePath!
             let items = try! fm.contentsOfDirectory(atPath: path)
             
             for item in items {
                 if item.hasPrefix("nssl") {

                    self.pictures.append(item)
                    save()
                 }
                self.pictures.sort()
            }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func save() {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: cells, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "cells")
        }
    }
}

