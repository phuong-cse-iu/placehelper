//
//  CustomFBMessengerShareActivity.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/17/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import UIKit
import FacebookShare

class CustomFBMessengerShareActivity: UIActivity {
   
    override var activityType: UIActivityType? {
        guard let bundleId = Bundle.main.bundleIdentifier else {return nil}
        return UIActivityType(rawValue: bundleId + "\(self.classForCoder)")
    }
    
    override var activityTitle: String? {
        return "Messenger"
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        
    }
    
//    override func perform() {
//        activityDidFinish(true)
//    }
    
    override func perform() {
        
        self.activityDidFinish(true)
    }
    
    
}
