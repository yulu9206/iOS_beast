//
//  JustBeastItTableViewController.swift
//  BeastList
//
//  Created by Lu Yu on 9/23/16.
//  Copyright © 2016 Lu Yu. All rights reserved.
//

import UIKit; import CoreData

class JustBeastItTableViewController: UITableViewController {
    
    weak var cancelDelegate: CancelButtonDelegate?
    weak var beastDelegate: JustBeastItTableViewControllerDelegate?
    var beastToEdit: Beast?
    var beastToEditIndexPathRow: Int?
    var date = Date()
    var beasted = false
    
    
    @IBOutlet weak var newBeastTextField: UITextField!
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        cancelDelegate?.cancelButtonPressedFrom(controller: self)
    }
    
    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        // for editing:
        if let beast = beastToEdit {
            beast.task = newBeastTextField.text!
            beastDelegate?.justBeastItViewController(self, didFinishEditingBeast: beast.task!, date: date, beasted: beasted)
        // for adding:
        } else {
            let task = newBeastTextField.text!
            beastDelegate?.justBeastItViewController(self, didFinishAddingBeast: task, date: date, beasted: beasted)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBeastTextField.text = beastToEdit?.task
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

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
        return 1
    }
    
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

}