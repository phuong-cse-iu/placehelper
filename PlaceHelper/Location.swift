//
//  Location.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/14/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {
        
    }
    
    var latitude: Double!
    var longtitude: Double!
}
