//
//  NotifyUser.swift
//  LocalNotifications
//
//  Created by Christopher Myers on 1/30/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import UserNotifications

@available(iOS 10.0, *)
class NotifyUser: NSObject, UNUserNotificationCenterDelegate {
    
    
    weak var notifyDelegate : UNUserNotificationCenterDelegate?
    
    override init() {
        super.init()
    }
    
    init(delegate: ViewController) {
        self.notifyDelegate = delegate
    }
    
    func registerLocal() {
        
        let center = UNUserNotificationCenter.current()
        
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) {
            (granted, error) in
            
            if granted {
                print("yay!")
                self.scheduleLocal()
            } else {
                print("D'oh!")
            }
        }
        
    }
    
    private func scheduleLocal() {
        // registerCategories()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Late Wake Up Call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData" : "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 22
        //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request, withCompletionHandler: nil)
        
        
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

}
