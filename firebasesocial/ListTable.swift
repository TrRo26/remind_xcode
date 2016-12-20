//
//  ListTable.swift
//  firebasesocial
//
//  Created by Apprentice on 12/18/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit
import Alamofire
import CoreMotion

class ListTable: UITableViewController {
    var table = ["a", "b", "c"]
    var currentAcceleration: Double = 0.0
    var motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        motionManager.accelerometerUpdateInterval = 1
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.main) {
            (data, error) in
            self.outputAccelerationData(acceleration: (data?.acceleration)!)
        }
    }
    
    func outputAccelerationData(acceleration: CMAcceleration) {
        print(acceleration)
    }
    
    
//        motionManager.startAccelerometerUpdates(to: OperationQueue.current, withHandler: CMAccelerometerData)
        
//            self.outputAccelerationData(CMAccelerometerData.acceleration)
//        if (error != nil) {
//            print("\(error")
//        }
        
    





//@property(readonly, nullable) CMAccelerometerData *accelerometerData __TVOS_PROHIBITED;
/*
 *  startAccelerometerUpdates
 *
 *		Starts accelerometer updates with no handler. To receive the latest accelerometer data
 *			when desired, examine the accelerometerData property.
 */
//- (void)startAccelerometerUpdates __TVOS_PROHIBITED;
/*
 *  startAccelerometerUpdatesToQueue:withHandler:
 *
 *		Starts accelerometer updates, providing data to the given handler through the given queue.
 *			Note that when the updates are stopped, all operations in the
 *			given NSOperationQueue will be cancelled.
 */
//- (void)startAccelerometerUpdatesToQueue:(NSOperationQueue *)queue withHandler:(CMAccelerometerHandler)handler __TVOS_PROHIBITED;
/*
 *  stopAccelerometerUpdates
 *
 *			Stop accelerometer updates.
 */
//- (void)stopAccelerometerUpdates __TVOS_PROHIBITED;





    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (table.count)
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let todoEndpoint: String = "http://remind-dbc.herokuapp.com/lists"
         // Standard GET request and parsed JSON object can be manipulated after it comes back from server
         Alamofire.request(todoEndpoint, method: .get)
         .responseJSON { response in
         // handle JSON here
            let json : NSDictionary? = response.result.value as! NSDictionary?
            var a = (json as? [String : String])?["name"]
//            var b = String(describing: type(of: a))
            print(a)

         }
        
     

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = table[indexPath.row]
        return cell
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

