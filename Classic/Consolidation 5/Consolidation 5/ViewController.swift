//
//  ViewController.swift
//  Consolidation 5
//
//  Created by Vyacheslav Pronin on 12/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit

    class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photos = [Photo]()
    public var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        // Do any additional setup after loading the view.
    }

//        override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let photo = photos[indexPath.row]
//           // let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {(_, self, _)  in
//                
//           //     tableView.deleteRows(at: [indexPath], with: .automatic)
//           // }
//        }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath)
        cell.textLabel?.text = photos[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            let path = getDocumentsDirectory().appendingPathComponent(photos[indexPath.row].image)
            vc.selectedImage = path.path
            vc.namePhoto = photos[indexPath.row].name
            vc.photo = photos[indexPath.row]
            vc.photos = photos
            vc.identifier = indexPath.row
            print(indexPath.row)
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
            let imageName = UUID().uuidString
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath)
        }
        
        counter += 1
        let photo =  Photo(name: "Photo Number: \(counter)", image: imageName)
        photos.insert(photo, at: 0)
        
        tableView.reloadData()
            dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    @objc func add() {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) { picker.sourceType = .camera }
        
        present(picker, animated: true)
    }
    
    
}

