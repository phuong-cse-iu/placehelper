//
//  MainVC.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/16/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import UIKit
import CoreLocation

class MainVC: UIViewController, CLLocationManagerDelegate {
    var myLocation:CLLocation!
    let apiKey:String = "AIzaSyAZQSsVV0p2XCFmtvsU0dzZr2gXaYQwxdE"
    @IBOutlet weak var goBtn: UIButton!
    @IBOutlet weak var txtFieldSearch: RightImageViewTxtField!
    // initialize location manager to process with gps signal
    let locManager = CLLocationManager()
    
    // update location when user's position has changed
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // pick the best location
        // the accuracy position is at index 0
        myLocation = locations[0]
    }
    
    // check whether user has allowed permission to user gps service
    func locationAuthStatus() {
        // already authorized. Ready to make request to Google
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            myLocation = locManager.location
            Location.sharedInstance.latitude = myLocation.coordinate.latitude
            Location.sharedInstance.longtitude = myLocation.coordinate.longitude
            
            
        } else {
            locManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // retrieve the current user's location with some setting
        // provide best accuracy when detect location
        // just use location gps service when app in use, not run in background
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        locManager.requestWhenInUseAuthorization()
        locManager.startUpdatingLocation()

        
        txtFieldSearch.delegate = self

        // Do any additional setup after loading the view.
        
        
////        goBtn.layer.cornerRadius = goBtn.bounds.size.height / 2
//        goBtn.layer.borderWidth = 2.0
//        goBtn.layer.borderColor = UIColor.white.cgColor
//        goBtn.clipsToBounds = true
        
//        goBtn.setTitle("Go", for: .normal)
        
        let image = UIImage(named: "go")
        
        
        goBtn.setImage(image, for: .normal)
        
        goBtn.contentMode = .center
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationAuthStatus()
    }

    @IBAction func goBtnPressed(_ sender: Any) {
        if txtFieldSearch.text == "" {
            let alertController = UIAlertController(title: "WARNING!!!", message: "Please type your place", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let request_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(txtFieldSearch.text!)&location=\(Location.sharedInstance.latitude!),\(Location.sharedInstance.longtitude!)&radius=500&key=\(apiKey)"
            
            let mapvc:MapVC = storyboard?.instantiateViewController(withIdentifier: "map") as! MapVC
            mapvc.req_url = request_url
            self.navigationController?.pushViewController(mapvc, animated: true)
            
        }

    }

}

extension MainVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtFieldSearch.resignFirstResponder()
        return true
    }
}


