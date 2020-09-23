//
//  ViewController.swift
//  Consolidation 10
//
//  Created by Vyacheslav Pronin on 18/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(addPicture))
        // Do any additional setup after loading the view.
    }

    @IBAction func addText(_ sender: Any) {
    }
    
    @IBAction func clearText(_ sender: Any) {
    }
    @IBAction func saveImage(_ sender: Any) {
    }
    @objc func addPicture() {
        
    }

}

