//
//  ListTable.swift
//  firebasesocial
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import Alamofire

class ListTable: UITableViewController {
    
    //MARK: INSTANCE VARIABLES & CONSTANTS
    var table = ["a"]
    
    //MARK: FUNCTIONS
    func siteInfo() -> Void {
        Alamofire.request("http://remind-dbc.herokuapp.com/items").responseJSON {
            response in
            let json = response.result.value as! NSDictionary
            self.table = (json["items"] as! NSArray) as! [String]
            self.tableView.reloadData()
 
        }
    }

    //MARK: OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        siteInfo()
        print(table)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          siteInfo()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (table.count)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = table[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            var deletion = table[indexPath.row]
            var itemInfo = ["list_id": 1, "name": deletion] as [String : Any]
            Alamofire.request("https://remind-dbc.herokuapp.com/items/1", method: .delete, parameters: ["item": itemInfo], encoding: JSONEncoding.default)
                .responseJSON { response in
            }
            table.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
