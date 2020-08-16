//
//  DetailViewController.swift
//  Consolidation 5
//
//  Created by Vyacheslav Pronin on 15/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var namePhoto: String = ""
    var photo: Photo?
    var table: UITableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageToload = selectedImage {
            print(imageToload)
            imageView.image = UIImage(named: imageToload)
            title = namePhoto
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More", style: .done, target: self, action: #selector(settingPhoto))
        
        
        // Do any additional setup after loading the view.
    }
    
   @objc func settingPhoto() {
          let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    ac.addAction(UIAlertAction(title: "To share", style: .default){ [weak self] _ in
        self?.chareTapped()
        
    })
        ac.addAction(UIAlertAction(title: "Rename", style: .default) { [weak self, weak table] _ in
            
          })
          ac.addAction(UIAlertAction(title: "Delete", style: .default, handler: nil))
          ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
          
          present(ac, animated: true)
      }

    func chareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else { return }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
