//
//  ViewController.swift
//  Project 15
//
//  Created by Vyacheslav Pronin on 23/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
    }

    @IBAction func tapped(_ sender: Any) {
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

