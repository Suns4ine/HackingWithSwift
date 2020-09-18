//
//  ViewController.swift
//  Consolidation 10
//
//  Created by Vyacheslav Pronin on 18/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addPicture))
        // Do any additional setup after loading the view.
    }

    @objc func addPicture() {
        
    }

}

