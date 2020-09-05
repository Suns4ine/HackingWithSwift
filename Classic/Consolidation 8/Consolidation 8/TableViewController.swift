//
//  ViewController.swift
//  Consolidation 8
//
//  Created by Vyacheslav Pronin on 04/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UINavigationControllerDelegate {

    var notes = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    
    @objc func addNote() {
        var note = ""
        notes.append(note)
        
        if let vc = storyboard?.instantiateInitialViewController(creator: <#T##((NSCoder) -> ViewController?)?##((NSCoder) -> ViewController?)?##(NSCoder) -> ViewController?#>)
    }

}

