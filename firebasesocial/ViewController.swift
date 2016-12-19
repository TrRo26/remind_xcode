//
//  ViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import UserNotifications
import CoreLocation
import MapKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
   
    
    @IBAction func afterlog(_sender: AnyObject){
        performSegue(withIdentifier: "afterlog", sender: self)
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // map stuff
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
    
        
        // Set URL for endpoint
        let todoEndpoint: String = "http://remind-dbc.herokuapp.com/lists"
        
        /*
        // Standard GET request and parsed JSON object can be manipulated after it comes back from server
        Alamofire.request(todoEndpoint, method: .get)
            .responseJSON { response in
                // handle JSON here
                guard let json = response.result.value as? [String: Any] else {
                    print("Didn't get list object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                print(json)
        }
 
         */

      
            
        
    
    }




//MARK: OUTLET















    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Yakakaaaa")
            return
        }
        
        
        
        if((FBSDKAccessToken.current()) != nil){
         let content = UNMutableNotificationContent()
        content.title = "User logged in"
        content.subtitle = "You are logged in"
        content.body = "SO loggged in"
        content.badge = 1
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
            let request = UNNotificationRequest(identifier: "auth", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
        }
        print(FBSDKAccessToken.current().userID)
        print("logged_in")
        afterlog(_sender: self)
        
    }
    
  
    
}

// POST request

//        let newList: [String: Any] = ["name": "Test API List", "user_id" : 1]
//        Alamofire.request(todoEndpoint, method: .post, parameters: ["list": newList], encoding: JSONEncoding.default)
//            .responseJSON { response in
//
//            guard response.result.error == nil else {
//                // got an error in getting the data, need to handle it
//                print("error calling POST on /lists")
//                print(response.result.error!)
//                return
//            }
//            // make sure we got some JSON since that's what we expect
//            guard let json = response.result.value as? [String: Any] else {
//                print("didn't get list object as JSON from API")
//                print("Error: \(response.result.error)")
//                return
//            }
//            guard let listName = json["name"] as? String else {
//                print("Could not get list name from JSON")
//                return
//            }
//            print("The title is: " + listName)
//        }



//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    let lastLocation: CLLocation = locations[locations.count - 1]
//    var userLatitude : String?
//    var userLongitude : String?
//    
//    userLatitude = String(format: "%.6f", lastLocation.coordinate.latitude)
//    userLongitude = String(format: "%.6f", lastLocation.coordinate.longitude)
//    
//    let userLocation: [String: Any] = ["location": ["latitude": userLatitude, "longitude": userLongitude]]
//    Alamofire.request(locationEndpoint, method: .get, parameters: ["location": userLocation], encoding: JSONEncoding.default)
//        .responseJSON { response in
//            
//            guard let json = response.result.value as? AnyObject else {
//                print("Didn't get list object as JSON from API")
//                print("Error: \(response.result.error)")
//                return
//            }
//            print(json)
//}

