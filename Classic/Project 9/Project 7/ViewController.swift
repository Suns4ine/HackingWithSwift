//
//  ViewController.swift
//  Project 7
//
//  Created by Vyacheslav Pronin on 21/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var petitions = [Petition]()
    var filtredPetitions = [Petition]()
    var arrayPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
      //  self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .done, target: self, action: #selector(printAPI))
        //self.navigationItem.leftBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchPetition)), UIBarButtonItem(title: "Clear", style: .done, target: self, action: #selector(clearSearch))]
       performSelector(inBackground: #selector(fetchJSON), with: nil)
       
        

    }
    
    @objc func clearSearch() {
        
        filtredPetitions.removeAll()
        arrayPetitions = petitions
        tableView.reloadData()
    }
    
    @objc func printAPI() {
        let ac = UIAlertController(title: "Warning", message: "The Data comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        present(ac, animated: true)
    }
    
    @objc func searchPetition() {
        let ac = UIAlertController(title: "Search", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let search = UIAlertAction(title: "Find", style: .default) { [petitions, weak self, weak ac] _ in
            
            guard let text = ac?.textFields?[0].text else { return }
            self?.filtredPetitions.removeAll()
            
            for petit in petitions {
                if petit.title.lowercased().contains(text.lowercased()) {
                    self?.filtredPetitions.append(petit)
                }
            }
            
            self?.arrayPetitions = self?.filtredPetitions ?? petitions
            self?.tableView.reloadData()
            
            
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.addAction(search)
        present(ac, animated: true)
        
    }
    
    @objc func fetchJSON() {
        let urlString: String

        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        //DispatchQueue.global(qos: .userInitiated).async {
                   if let url = URL(string: urlString) {
                       if let data = try? Data(contentsOf: url) {
                           self.parse(json: data)
                           return
                       }
                   }

                   
                   
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
                   
          //     }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPetitions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = arrayPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = arrayPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            arrayPetitions = petitions
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            tableView.performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    @objc func showError() {
        //DispatchQueue.main.async {
            let ac = UIAlertController(title: "Loading eroor", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(ac, animated: true)
        }
    //}
    
}

