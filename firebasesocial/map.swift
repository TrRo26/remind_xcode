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


class map: UIViewController, CLLocationManagerDelegate {

    
    var i = 0
    
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    var currentLocation = CLLocation()
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        self.map.showsUserLocation = true
        currentLocation = location
        print(location.speed)
        

      
        while i < 1 {
            print(i)
                var currentLat = location.coordinate.latitude
                var currentLon = location.coordinate.longitude
            let url = "http://remind-dbc.herokuapp.com/maps?location[latitude]=41.87&location[longitude]=-87.65"
                Alamofire.request(url, method: .get)
                    .responseJSON { response in
                        // handle JSON here
                        let json : NSDictionary? = response.result.value as! NSDictionary?
                        print("hey")

                        var a = json?["locations"] as! NSArray
                        var x = 0
                        while x < a.count {
                        print("_________")
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
                                print(oop)
                                print(doop)
                                print(geep)
                                let myNewLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as CLLocationDegrees)
                                let anon = MKPointAnnotation()
                                anon.coordinate = myNewLocation
                                anon.title = title
                                anon.subtitle = itemables
                                self.map.addAnnotation(anon)

                            
                            }
                        print("_________")
                        x = x + 1
                        }
                }

         

            i = i + 1
        }
        

            
   
        
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
   

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
   
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
