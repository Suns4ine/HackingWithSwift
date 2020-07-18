//
//  ViewController.swift
//  Project 6b
//
//  Created by Vyacheslav Pronin on 18/07/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.backgroundColor = UIColor.red
        label1.text = "THESE"
        label1.sizeToFit()
    
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.backgroundColor = UIColor.cyan
        label2.text = "ARE"
        label2.sizeToFit()
        
        let label3 = UILabel()
        label3.translatesAutoresizingMaskIntoConstraints = false
        label3.backgroundColor = UIColor.yellow
        label3.text = "SOME"
        label3.sizeToFit()
        
        let label4 = UILabel()
        label4.translatesAutoresizingMaskIntoConstraints = false
        label4.backgroundColor = UIColor.green
        label4.text = "AWESOME"
        label4.sizeToFit()
        
        let label5 = UILabel()
        label5.translatesAutoresizingMaskIntoConstraints = false
        label5.backgroundColor = UIColor.orange
        label5.text = "LABES"
        label5.sizeToFit()
        
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)

//        let viewDictionary = ["label1" : label1, "label2" : label2, "label3" : label3, "label4" : label4, "label5" : label5]
//        let metrics = ["labelHeight" : 88]
//
//        for label in viewDictionary.keys {
//                 view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewDictionary))
//        }
//
//        view.addConstraints( NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1(labelHeight@999)]-[label2(label1)]-[label3(label1)]-[label4(label1)]-[label5(label1)]->=10-|", options: [], metrics: metrics, views: viewDictionary))
//
        var previous: UILabel?
        var arrayLabel = [label1, label2, label3, label4, label5]
        
        let heightLabel = (UIScreen.main.bounds.height - 50)/5
        
        for label in arrayLabel {
            
            //label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            //label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            //label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 88).isActive = true
            label.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.19).isActive = true
            //label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5, constant: 50).isActive = true
           // label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
            
            if let previous = previous {
                label.topAnchor.constraint(equalTo: previous.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
            }
            
            previous = label
        }
    }

}

