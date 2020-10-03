//
//  ViewController.swift
//  Consolidation 12
//
//  Created by Vyacheslav Pronin on 30/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelArray: [UILabel]!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newTheme))
        // Do any additional setup after loading the view.
    }

    @objc func newTheme() {
        
    }

}

