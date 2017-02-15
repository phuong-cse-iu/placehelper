//
//  ViewController.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/13/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    // user's location
    var myLocation:CLLocation!
    @IBOutlet weak var txtFieldSearch: UITextField!
    @IBOutlet weak var btnGo: UIButton!
    let apiKey:String = "AIzaSyAZQSsVV0p2XCFmtvsU0dzZr2gXaYQwxdE"
    var playerLayer:AVPlayerLayer!
    let locManager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        myLocation = locations[0]
        
//        print(myLocation.coordinate.latitude)
//        print(myLocation.coordinate.longitude)
        
//        let request_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=atm&location=\(myLocation.coordinate.latitude),%\(myLocation.coordinate.longitude)&radius=500&key=\(apiKey)"
//        
//        print(request_url)
    }
    
    
    
    
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
        
        self.navigationItem.title = "Welcome"
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Savoye LET", size: 40)!]
        
        self.txtFieldSearch.delegate = self
        txtFieldSearch.settingTextField()
        btnGo.settingBtn()
        
        
        //        let request_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=atm&location=10.778421,%20106.685318&radius=500&key=\(gmApiKey)"
        //
        //        let url:URL = URL(string: request_url)!
        //        let urlRequest = URLRequest(url: url)
        //        let session = URLSession.shared
        //        session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
        //
        //            do {
        //               let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
        //               print(object)
        //            } catch {
        //                
        //            }
        //            
        //        }).resume()
        
        playerLayer = AVPlayerLayer()
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")
        let url:URL = URL(fileURLWithPath: path!)
        playerLayer.player = AVPlayer(url: url)
        view.layer.insertSublayer(playerLayer, at: 0)
        playerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        
    }
    
    
    func loopVideo() {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerLayer.player?.currentItem, queue: nil) { (_) in
            DispatchQueue.main.async {
                self.playerLayer.player?.seek(to: kCMTimeZero)
                self.playerLayer.player?.play()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.locationAuthStatus()
        playerLayer.player?.play()
        loopVideo()
    }
    
    @IBAction func aBtn(_ sender: Any) {
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


// design textfield
extension UITextField {
    func settingTextField() {
        self.borderStyle = .bezel
        self.attributedPlaceholder = NSAttributedString(string: "Search places", attributes: [NSForegroundColorAttributeName: UIColor.white])
        self.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.backgroundColor = UIColor(red:0.67, green:0.67, blue:0.67, alpha:1)
        
        self.alpha = 0.5
        self.leftViewMode = UITextFieldViewMode.always
        let imgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let img = UIImage(named: "search")
        imgView.image = img
        self.leftView = imgView
    }
}

// design button
extension UIButton {
    func settingBtn() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true

    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtFieldSearch.resignFirstResponder()
        return true
    }
}



