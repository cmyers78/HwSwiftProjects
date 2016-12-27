//
//  ViewController.swift
//  StormViewer
//
//  Created by Christopher Myers on 12/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // lets us work with the file system
        let fm = FileManager.default
        // path to the directory containing our assets
        let path = Bundle.main.resourcePath!
        // creates an array of items in the directory at our path
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                //print(item)
                // This is a picture to load
                self.pictures.append(item)
                
            }
        print(pictures)
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

