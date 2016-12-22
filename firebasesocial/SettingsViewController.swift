//
//  SettingsViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/21/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: INSTANCE VARIABLES & CONSTANTS
    
    //MARK: OUTLETS
    @IBOutlet weak var pushSwitch: UISwitch!
    
    //MARK: ACTIONS
    @IBAction func pushSwitchAction(_ sender: UISwitch) {
        print(pushSwitch.isOn)
    }
    
    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: FUNCTIONS
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
