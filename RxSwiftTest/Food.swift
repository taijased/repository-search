//
//  Food.swift
//  RxSwiftTest
//
//  Created by Maxim Spiridonov on 19/04/2019.
//  Copyright © 2019 Maxim Spiridonov. All rights reserved.
//

import Foundation
import UIKit

struct Food {
    let name: String
    let flickeID: String
    var image: UIImage?
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickeID = flickrID
        image = UIImage(named: flickrID)
        
    }
}


extension Food: CustomStringConvertible {
    var description: String {
        return "\(name): flickr.com/\(flickeID)"
    }
}
