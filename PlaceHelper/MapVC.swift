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

    var places:Array<Place> = []
    var req_url:String!
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(req_url)
        mapView.setupMap(lat: Location.sharedInstance.latitude, lon: Location.sharedInstance.longtitude, span: 0.01)
        mapView.showsUserLocation = true
        
//        let diadiem1:MKPointAnnotation = MKPointAnnotation()
//        let loc:CLLocation = CLLocation(latitude: 10.778421, longitude: 106.685318)
//        let loc2D:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
//        diadiem1.coordinate.latitude = loc2D.latitude
//        diadiem1.coordinate.longitude = loc2D.longitude
//        diadiem1.title = "SVHTB"
//        mapView.addAnnotation(diadiem1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if ((req_url) != nil) {
            let url = URL(string: req_url)
            let urlRequest = URLRequest(url: url!)
            let session = URLSession.shared
            session.dataTask(with: urlRequest, completionHandler: { (data, response, err) in
                if err != nil {
                    //                print(err)
                }
                do {
                    if (data != nil) {
                        let object:Dictionary<String, AnyObject> = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! Dictionary<String, AnyObject>
                        
                        let results:Array<Dictionary<String, AnyObject>> = object["results"] as! Array<Dictionary<String, AnyObject>>
                        if (results != nil) {
                            for result in results {
                                self.places.append(Place(result: result))
                            }
                            
                            DispatchQueue.main.async {
                                for place in self.places {
                                    self.mapView.addPlace(lat: place.lat, lng: place.lng, title: place.address, subTitle: place.name)
                                }
                            }
                        }
                        
                    }
                    
                } catch {
                    
                }
                
            }).resume()
        }

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
    
    func addPlace(lat:Double, lng:Double, title:String, subTitle:String) {
        let anno:MKPointAnnotation = MKPointAnnotation()
        let toadovatly:CLLocation = CLLocation(latitude: lat, longitude: lng)
        let toadobando:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: toadovatly.coordinate.latitude, longitude: toadovatly.coordinate.longitude)
        anno.coordinate.latitude = toadobando.latitude
        anno.coordinate.longitude = toadobando.longitude
        anno.title = title
        anno.subtitle = subTitle
        self.addAnnotations([anno])
    }
}
