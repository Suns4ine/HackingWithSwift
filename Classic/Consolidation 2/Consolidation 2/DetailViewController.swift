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
    var text = ""
    let appName = Bundle.appName()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
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
    @objc func shareTapped() {
        
        
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        text = """
This is \(selectedImage?.capitalized ?? "No name found")
I sent it through "\(appName)" application
"""

        let vc = UIActivityViewController(activityItems: [text, image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
