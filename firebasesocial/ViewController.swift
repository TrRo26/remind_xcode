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
    
    //MARK: OUTLETS
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var userTextField: UITextField!
    
    //MARK: ACTION
    @IBAction func afterlog(_sender: AnyObject){
        performSegue(withIdentifier: "afterlog", sender: self)
    }
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Map stuff
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in
        })
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 535, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        
        // Set URL for endpoint
        let todoEndpoint: String = "http://remind-dbc.herokuapp.com/lists"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if((FBSDKAccessToken.current()) != nil){
            pwTextField.isHidden = true
            userTextField.isHidden = true
            
        } else {
            pwTextField.isHidden = false
            userTextField.isHidden = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: FUNCTIONS
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out")
        if((FBSDKAccessToken.current()) != nil){
            pwTextField.isHidden = true
            userTextField.isHidden = true
            
        } else {
            pwTextField.isHidden = false
            userTextField.isHidden = false
        }
        
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print("Error getting token")
            return
        }
        
        afterlog(_sender: self)
    }
}
