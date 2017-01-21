//
//  ViewController.swift
//  AnimationsProject
//
//  Created by Christopher Myers on 1/21/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tap: UIButton!
    
    var imageView: UIImageView!
    var currentAnimation = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tapped(_ sender: Any) {
        
        tap.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: { [unowned self] in switch self.currentAnimation {
        case 0:
            self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        case 1:
            self.imageView.transform = CGAffineTransform.identity
        case 2:
            self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
        case 3:
            self.imageView.transform = CGAffineTransform.identity
        default:
            break
            
            }
        }) {
            [unowned self] (finished: Bool) in self.tap.isHidden = false
        }
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
        
        
    }
}

