//
//  ViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/16/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBAction func afterlog(_sender: AnyObject){
        performSegue(withIdentifier: "afterlog", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.delegate = self
        loginButton.readPermissions = ["email"]
    }
    
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
            var cool = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email, id, name, first_name, last_name"]).start(completionHandler: { (connection, result, error) -> Void in print(result)})
        }
        print(FBSDKAccessToken.current().userID)
        print("logged_in")
        afterlog(_sender: self)
        
    }
    
  
    
}
 
