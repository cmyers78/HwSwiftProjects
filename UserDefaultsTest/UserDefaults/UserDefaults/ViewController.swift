//
//  ViewController.swift
//  UserDefaults
//
//  Created by Christopher Myers on 1/18/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseTouchID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Chris Myers", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        
        var array = ["The night is dark", "and full of terrors", "Valar Morghulis"]
        defaults.set(array, forKey: "SavedArray")
        
        var dict = ["Name" : "Cersei", "Country" : "Westeros"]
        defaults.set(dict, forKey: "SavedDict")
        
        
        let arrayLoad = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        print(arrayLoad)
        
        let loadDict = defaults.object(forKey: "SavedDict") as? [String : String] ?? [String : String]()
        print(loadDict)
        
        array.append("Valar Dohaeris")
        defaults.set(array, forKey: "SavedArray")
        
        
        
        
        let loadedAge = defaults.object(forKey: "Age")
        print(loadedAge ?? 0)
        
        print("updating the key")
        defaults.set(38, forKey: "Age")
        defaults.synchronize()
       
        
        print("loading key")
        let newAge = defaults.object(forKey: "Age")
        print(newAge ?? 0)
        
        let updatdArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        print(updatdArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

