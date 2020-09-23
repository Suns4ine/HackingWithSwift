//
//  ViewController.swift
//  Project 28
//
//  Created by Vyacheslav Pronin on 19/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet var secret: UITextView!
    var stringpassword = ""
    var isPassword: Bool!
   
    @IBAction func autenticateTapped(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identifity yourself!"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] succes, authenticationError in
                
                DispatchQueue.main.async {
                    if succes {
                        self?.navigationController?.setNavigationBarHidden(false, animated: true)
                        self?.unlockSecretMessage()

                    } else {
                        let ac = UIAlertController(title: "Authentication failed", message: "You could not be verified; please try again", preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "Ok", style: .default))
                        self?.present(ac, animated: true)
                        
                    }
                }
            }
        } else {
            if isPassword == false {
                let ac = UIAlertController(title: "New Password", message: nil, preferredStyle: .alert)
                ac.addTextField()
                
                let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
                    guard let answer = ac?.textFields?[0].text else { return }
                    
                    if answer.isEmpty { return }
                    self?.isPassword = true
                    self?.stringpassword = answer
                    self?.checkPassword(pass: answer)
                    
                }
                ac.addAction(submitAction)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(ac, animated: true)
            } else {
                let ac = UIAlertController(title: "Check Password", message: nil, preferredStyle: .alert)
                ac.addTextField()
                
                let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] action in
                    guard let answer = ac?.textFields?[0].text else { return }
                    
                    if answer.isEmpty { return }
                    self?.checkPassword(pass: answer)
                }
                ac.addAction(submitAction)
                ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                
                present(ac, animated: true)
                
            }
//            let ac = UIAlertController(title: "Biometry unavalible", message: "Your device is not configured for biometric authentification", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Ok", style: .default))
//            self.present(ac, animated: true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Nothing to see here"
        

        isPassword = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSecretMessage))
         navigationController?.setNavigationBarHidden(true, animated: true)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        notificationCenter.addObserver(self, selector: #selector(saveSecretMessage), name: UIApplication.willResignActiveNotification, object: nil)

    }
    

    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
     
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    @objc func saveSecretMessage() {
        guard secret.isHidden == false else { return }
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        secret.resignFirstResponder()
        secret.isHidden = true
        title = "Nothing to see here"
    }
    
    func unlockSecretMessage() {
        secret.isHidden = false
        title = "Secret stuff!"
        
        if let text = KeychainWrapper.standard.string(forKey: "SecretMessage") {
            secret.text = text
        }
    }
    
    func checkPassword(pass: String) {
        if pass == stringpassword || stringpassword == nil {
            navigationController?.setNavigationBarHidden(false, animated: true)
            unlockSecretMessage()
        } else {
            let ac = UIAlertController(title: "Oops", message: "Your password is not correct", preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            
            present(ac, animated: true)
        }
    }

}

