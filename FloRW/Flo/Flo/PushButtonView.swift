//
//  PushButtonView.swift
//  Flo
//
//  Created by Christopher Myers on 1/20/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

@IBDesignable

class PushButtonView: UIButton {

    override func draw(_ rect: CGRect) {
        var path = UIBezierPath(ovalIn: rect)
        UIColor.blue.setFill()
        path.fill()
        
        // set up the width and height variables
        let plusHeight : CGFloat = 3.0
        let plusWidth : CGFloat = min(bounds.width, bounds.height) * 0.6
        
        // create a path
        var plusPath = UIBezierPath()
        
        // set path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        
        plusPath.move(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2))
        
        plusPath.addLine(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2))
        
        
    }

}
