//
//  DetailViewController.swift
//  Consolidation 2
//
//  Created by Vyacheslav Pronin on 13/06/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            title = selectedImage?.uppercased()
            imageView.image  = UIImage(named: imageToLoad)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                navigationController?.hidesBarsOnTap = true
            }

    override func viewWillDisappear(_ animated: Bool) {
                super.viewWillDisappear(animated)
                navigationController?.hidesBarsOnTap = false
            }
    

}
