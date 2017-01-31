//
//  NextViewController.swift
//  LocalNotifications
//
//  Created by Christopher Myers on 1/30/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import UserNotifications

class NextViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("new View")
        
        
      // NotifyUser().registerLocal()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // NotifyUser().registerLocal()
        //notify.registerLocal()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
