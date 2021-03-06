//
//  ViewController.swift
//  Project 21
//
//  Created by Vyacheslav Pronin on 02/09/2020.
//  Copyright © 2020 Vyacheslav Pronin. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shedule", style: .plain, target: self, action: #selector(sheduleLocal))
        
    }

    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {(granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
        
    }
    
    @objc func sheduleLocal() {
        let center = UNUserNotificationCenter.current()
        
        let content = UNMutableNotificationContent()
        content.title = "Late wake up all"
        content.body = "The early bird cathes the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 30
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
    
    func registerCategories() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])

        center.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String {
            print("Custom data recervied: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")
            case "show":
                print("Show more information...")
            default:
                break
            }
        }
        
        completionHandler()
    }

}

