//
//  ViewController.swift
//  StormViewer
//
//  Created by Christopher Myers on 12/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Storm Viewer"
        
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to the be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            
            // 2: Success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]
            
            // 3: Push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}

