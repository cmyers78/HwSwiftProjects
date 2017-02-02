//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Christopher Myers on 1/26/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import UserNotifications


@available(iOS 10.0, *)
class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    let notify = NotifyUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notify.notifyDelegate = self
        notify.registerLocal()
        
        // Create button bar items on navigation bar
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //NotifyUser().registerLocal()
        
    }

//    func registerLocal() {
//        
//        let center = UNUserNotificationCenter.current()
//        
//        center.requestAuthorization(options: [.alert, .badge, .sound]) {
//            (granted, error) in
//            
//            if granted {
//                print("yay!")
//                self.scheduleLocal()
//            } else {
//                print("D'oh!")
//            }
//        }
//        
//    }
//    
//    func scheduleLocal() {
//       // registerCategories()
//        let center = UNUserNotificationCenter.current()
//        
//        let content = UNMutableNotificationContent()
//        content.title = "Late Wake Up Call"
//        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customData" : "fizzbuzz"]
//        content.sound = UNNotificationSound.default()
//        
//        var dateComponents = DateComponents()
//        dateComponents.hour = 7
//        dateComponents.minute = 22
//        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
//        
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request, withCompletionHandler: nil)
//        //center.removeAllPendingNotificationRequests()
//        
//    }
    
//    func registerCategories() {
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self
//        
//        let later = UNNotificationAction(identifier: "later", title: "Read Later...", options: [])
//        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
//        
//        let category = UNNotificationCategory(identifier: "alarm", actions: [later, show], intentIdentifiers: [])
//        
//        center.setNotificationCategories([category])
//        
//    }
    
    func printStuff() {
        print(" I need to stop the timer")
    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        
//        if let customData = userInfo["customData"] as? String {
//            print("Custom data received: \(customData)")
//            
//            switch response.actionIdentifier {
//            case UNNotificationDefaultActionIdentifier:
//                print("Default identifer")
//                case "show":
//                //the user tapped our "show more info..." button
//                print("show more information")
//                break
//            default:
//                break
//                
//            }
//        }
//        
//        completionHandler()
//        
//        
//        
//        
//    }

    @IBAction func nextScreen(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
        
        
    }
}

