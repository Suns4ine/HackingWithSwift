//
//  DetailViewController.swift
//  Project 1
//
//  Created by Vyacheslav Pronin on 06/06/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var namePicture: String?
    var maxArrayPicture: String?
    var selectedImage: String?
    let appName = Bundle.appName()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(namePicture ?? ":)No position") from \(maxArrayPicture ?? "(:No Array Picture")" //selectedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToload = selectedImage {
            imageView.image = UIImage(named: imageToload)
        }
        
        

        // Do any additional setup after loading the view.
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
        guard var nameImage = selectedImage else {
            print ("No name image found")
            return
        }

        nameImage = """
        In \(appName)
        name photo: \(selectedImage ?? "no name :)")
"""
        let vc = UIActivityViewController(activityItems: [image, nameImage], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
