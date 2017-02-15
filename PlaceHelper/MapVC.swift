//
//  MapVC.swift
//  PlaceHelper
//
//  Created by TranTPhuong on 2/13/17.
//  Copyright © 2017 Trunky Foundation. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    var req_url:String!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(req_url)
        mapView.setupMap(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longtitude, span: 0.01)
        mapView.showsUserLocation = true
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let url = URL(string: req_url)!
        let urlRequest = URLRequest(url: url)
        let session = URLSession.shared
        session.dataTask(with: urlRequest, completionHandler: { (data, response, err) in
            if err != nil {
                print(err)
            }
            do {
                if (data != nil) {
                    let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    print(object)
                    
                }
                
            } catch {
                
            }
            
        }).resume()
    }
}

extension MKMapView {
    func setupMap(lat:Double, lon:Double, span:Double) {
        let toadovatly:CLLocation = CLLocation(latitude: lat, longitude: lon)
        let toadobando:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: toadovatly.coordinate.latitude, longitude: toadovatly.coordinate.longitude)
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region:MKCoordinateRegion = MKCoordinateRegion(center: toadobando, span: span)
        self.setRegion(region, animated: true)
    }
}
