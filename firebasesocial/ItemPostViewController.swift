//
//  ItemPostViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation
import UserNotifications

class ItemPostViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    var name = ""
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBAction func buttonClick(_ sender: UIButton) {
        print(textFieldName.text!)
        name = textFieldName.text!
        let gotoplace: String = "http://remind-dbc.herokuapp.com/items"
        let newList: [String: Any] = ["name": name, "list_id" : 1]
        Alamofire.request(gotoplace, method: .post, parameters: ["item": newList], encoding: JSONEncoding.default)
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /lists")
                    print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get list object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                guard let listName = json["name"] as? String else {
                    print("Could not get list name from JSON")
                    return
                }
                print("The title is: " + listName)
                
        }

    }

////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    var locationManager: CLLocationManager = CLLocationManager()
  
    
    
     // Standard GET request and parsed JSON object can be manipulated after it comes back from server

     
 
    
    





func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let lastLocation: CLLocation = locations[locations.count - 1]
    
    //        var userLatitude = String(format: "%.6f", lastLocation.coordinate.latitude)
    //        var userLongitude = String(format: "%.6f", lastLocation.coordinate.longitude)
    
    latitudeLabel.text = String(format: "%.6f", lastLocation.coordinate.latitude)
    longitudeLabel.text = String(format: "%.6f", lastLocation.coordinate.longitude)
    
    //        var userLocation = ["location": ["latitude": userLatitude , "longitude": userLongitude]]
    var todoEndpoint = "https://remind-dbc.herokuapp.com/maps?location[latitude]=\(String(format: "%.6f", lastLocation.coordinate.latitude))&location[longitude]=\(String(format: "%.6f", lastLocation.coordinate.longitude))"
    let newList: [String: Any] = ["latitude": String(format: "%.6f", lastLocation.coordinate.latitude), "longitude" : String(format: "%.6f", lastLocation.coordinate.longitude)]
    Alamofire.request(todoEndpoint, method: .get)
        .responseJSON { response in
            // handle JSON here
            let json : NSArray? = response.result.value as! NSArray?
            print("hey")
            print(json)
            if((json?.count)! >= 0){
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


    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!









    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
