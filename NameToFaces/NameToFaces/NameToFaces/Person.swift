//
//  Person.swift
//  NameToFaces
//
//  Created by Christopher Myers on 1/10/17.
//  Copyright © 2017 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name : String
    var image : String
    
    init(name : String, image : String) {
        self.name = name
        self.image = image
    }
}
