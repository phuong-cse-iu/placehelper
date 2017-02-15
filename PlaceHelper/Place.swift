//
//  Place.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/15/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import UIKit

struct Place {
    var name:String
    var address:String
    var lat:Double
    var lng:Double
    var geometry:Dictionary<String,AnyObject>!
    var location:Dictionary<String, AnyObject>!
    
    init() {
        name = ""
        address = ""
        lat = 0.0
        lng = 0.0
    }
    
    init(result:Dictionary<String, AnyObject>) {
        self.name = result["name"] as! String
        self.address = result["formatted_address"] as! String
        geometry = result["geometry"] as! Dictionary<String, AnyObject>
        location = geometry["location"] as! Dictionary<String, AnyObject>
        self.lat = location["lat"] as! Double
        self.lng = location["lng"] as! Double
    }
}
