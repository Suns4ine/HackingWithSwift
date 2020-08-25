//
//  DetailViewController.swift
//  Consolidation 6
//
//  Created by Vyacheslav Pronin on 25/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {



    var country: Country!
    @IBOutlet var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard country != nil else { return }
        
        title = "\(country.name)"
        text.text = """
        Capital Sity: \(country.capitalSity)
        
        Value: \(country.value)
        
        Peoples: \(country.peoples)
        
        Size: \(country.size) км в квадрате
        
        Bio: \(country.bio)
        """
    }
    

}
