//
//  ItemPostViewController.swift
//  firebasesocial
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class ItemPostViewController: UIViewController {
    var name = ""
    
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBAction func buttonClick(_ sender: UIButton) {
        print(textFieldName.text!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

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
