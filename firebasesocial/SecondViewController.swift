//
//  SecondViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/17/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var name: String = ""
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var labelName: UILabel!

    @IBAction func buttonClick(_ sender: UIButton) {
        name = textFieldName.text!
        labelName.text = name
    }
}
