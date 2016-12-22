//
//  map.swift
//  firebasesocial
//
//  Created by Apprentice on 12/19/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Alamofire
import UserNotifications

class map: UIViewController, CLLocationManagerDelegate {
    
    //MARK: INSTANCE VARIABLES & CONSTANTS
    var i = 0
    var gatekeeper = false
    let manager = CLLocationManager()
    var locationManager: CLLocationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D() as CLLocationCoordinate2D
    
    //MARK: OUTLETS
    @IBOutlet weak var map: MKMapView!
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
//        manager.delegate = self
//        manager.desiredAccuracy = kCLLocationAccuracyBest
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if gatekeeper == false {
        print("cheeky")
        locationManager.startUpdatingLocation()
        }
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(currentLocation, span)
//        map.setRegion(region, animated: true)
//        self.map.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    //MARK: FUNCTIONS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0] as CLLocation
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        self.currentLocation = myLocation
        print(self.currentLocation)
        if gatekeeper == false {
            let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            map.setRegion(region, animated: true)
            self.map.showsUserLocation = true
            print(location.speed)
            print("this happens once andrew")
            self.gatekeeper = true
        }
        while i < 1 {
            print(i)
                var currentLat = location.coordinate.latitude
                var currentLon = location.coordinate.longitude
            
            let url = "http://remind-dbc.herokuapp.com/maps?location[latitude]=\(currentLat)&location[longitude]=\(currentLon)"
                Alamofire.request(url, method: .get)
                    .responseJSON { response in
                        let json : NSDictionary? = response.result.value as! NSDictionary?
                        var a = json?["locations"] as! NSArray
                        var x = 0
                        while x < a.count {
                        var b = a[x] as! NSDictionary
                            for (key, value) in b{
                                print(key)
                                var title = key as! String
                                var whatever = value as! NSDictionary
                                var oop = whatever["address"]
                                var doop = whatever["location"] as! NSDictionary
                                var lat = doop["lat"] as! CLLocationDegrees
                                var lng = doop["lng"] as! CLLocationDegrees
                                var geep = whatever["items"] as! NSArray
                                var itemables = geep.componentsJoined(by: ", ") as! String
                                let myNewLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as CLLocationDegrees)
                                let anon = MKPointAnnotation()
                                anon.coordinate = myNewLocation
                                anon.title = title
                                anon.subtitle = itemables
                                self.map.addAnnotation(anon)
                            }
                            x = x + 1
                        }
                }
                i = i + 1
        }
    }
    
    func locationManagerN(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation: CLLocation = locations[locations.count - 1]
        
        var userLatitude = String(format: "%.6f", lastLocation.coordinate.latitude)
        var userLongitude = String(format: "%.6f", lastLocation.coordinate.longitude)
        
        var userLocation = ["location": ["latitude": userLatitude , "longitude": userLongitude]]
        var todoEndpoint = "https://remind-dbc.herokuapp.com/maps?location[latitude]=\(String(format: "%.6f", lastLocation.coordinate.latitude))&location[longitude]=\(String(format: "%.6f", lastLocation.coordinate.longitude))"
        let newList: [String: Any] = ["latitude": String(format: "%.6f", lastLocation.coordinate.latitude), "longitude" : String(format: "%.6f", lastLocation.coordinate.longitude)]
        Alamofire.request(todoEndpoint, method: .get)
            .responseJSON { response in
                // handle JSON here
                let json : NSDictionary? = response.result.value as! NSDictionary?
                print("hey")
                print(json)
                if((json?.count)! >= 1){
                    let content = UNMutableNotificationContent()
                    content.title = "Hey do that thing"
                    content.subtitle = "it was on your list"
                    content.body = "do it"
                    content.badge = 1
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
                    let request = UNNotificationRequest(identifier: "item", content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
                }
        }
    }
    
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
