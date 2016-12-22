//
//  ItemPostViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import Alamofire

class ItemPostViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: INSTANCE VARIABLES & CONSTANTS
    var name = ""
    
    //MARK: OUTLETS
    @IBOutlet weak var textFieldName: UITextField!
    
    //MARK: ACTIONS
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
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
