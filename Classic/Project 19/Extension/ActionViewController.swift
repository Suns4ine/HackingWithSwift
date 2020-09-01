//
//  ActionViewController.swift
//  Extension
//
//  Created by Vyacheslav Pronin on 31/08/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet var script: UITextView!
    var arrrayURLJavaScript = [ URL : String ]()
    
    var pageTitle = ""
    var pageURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        
        if let savedArray = defaults.object(forKey: "arrrayURLJavaScript") as? Data {
            if let decodedArray = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedArray) as? [URL: String] {
                arrrayURLJavaScript = decodedArray
                print(arrrayURLJavaScript.keys)////////////////////////
            }
        }

        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: .add, style: .done, target: self, action: #selector(addCode))
        
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem {
            if let itemProvider = inputItem.attachments?.first {
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String) { [weak self] (dict, error) in
                    guard let itemDictionary = dict as? NSDictionary else { return }
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else { return }
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }

    @IBAction func done() {
        let item = NSExtensionItem()
        save()
        let argument: NSDictionary = ["customJavascript": script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey: argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
    }
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardvalue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardvalue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }
    
    @objc func addCode() {
        let vc = UIAlertController(title: "JavaScript", message: nil, preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "Alert", style: .default) { [weak self] _ in
            self?.script.text = "alert(document.title);"
            self?.done()
        })
        vc.addAction(UIAlertAction(title: "window", style: .default){ [weak self] _ in
            self?.script.text = "window.open('https://apple.com');"
            self?.done()
        })
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(vc, animated: true)
    }
    
    func save () {
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: arrrayURLJavaScript, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "arrrayURLJavaScript")
        }
    }

}
