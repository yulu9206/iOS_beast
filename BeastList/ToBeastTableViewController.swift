//
//  ToBeastTableViewController.swift
//  BeastList
//
//  Created by Lu Yu on 9/23/16.
//  Copyright © 2016 Lu Yu. All rights reserved.
//

import UIKit; import CoreData

class ToBeastTableViewController: UITableViewController, ToBeastCustomCellDelegate, CancelButtonDelegate, JustBeastItTableViewControllerDelegate {
    
    var beasts = [Beast]()
    var unBeastedBeasts = [Beast]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateBeasted = Date()
    let doneBeasted = true
    
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "JustBeastIt", sender: -1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUnBeastedBeasts()
        appendBeasts(beasts: beasts)
        print(unBeastedBeasts)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // for JustBeastIt delegate:
    func justBeastItViewController(_ controller: JustBeastItTableViewController, didFinishAddingBeast task: String, date: Date, beasted: Bool) {
        dismiss(animated: true, completion: nil)
        let newBeast = NSEntityDescription.insertNewObject(forEntityName: "Beast", into: context)
        do {
            newBeast.setValue(task, forKey: "task")
            newBeast.setValue(date, forKey: "date")
            newBeast.setValue(beasted, forKey: "beasted")
            try context.save()
            print("Success, \(newBeast) added!")
            unBeastedBeasts.append(newBeast as! Beast)
        } catch {
            print("Failure to save: \(error)")
        }
        fetchUnBeastedBeasts()
        tableView.reloadData()
        
    }
    
    func justBeastItViewController(_ controller: JustBeastItTableViewController, didFinishEditingBeast task: String, date: Date, beasted: Bool) {
        dismiss(animated: true, completion: nil)
        if context.hasChanges {
            do {
                try context.save()
                print("Success, \(task) edited and saved!")
            } catch {
                print("Failure to save: \(error)")
            }
        }
        fetchUnBeastedBeasts()
        tableView.reloadData()
    }
    
    func fetchUnBeastedBeasts() {
        do {
            let results = try context.fetch(Beast.fetchRequest())
            beasts = results as! [Beast]
        } catch {
            print(error)
        }
    }
    
    func appendBeasts(beasts: [Beast]) {
        for beast in beasts {
            if beast.beasted == true{
                print("\(beast.task) is Beasted")
            } else {
                unBeastedBeasts.append(beast)
                print("\(beast.task) is UnBeasted")
            }
        }
    }
    
    // for cancel button delegate:
    func cancelButtonPressedFrom(controller: UITableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // for custom cell delegate for BEASTING:
    func didSelectButtonAtIndexPathOfCell(sender: ToBeastCustomCell) {
        let index = tableView.indexPath(for: sender)
        let row = (index?.row)!
        print((index?.row)!)
        let beastedBeast = unBeastedBeasts[row]
        do {
            beastedBeast.setValue(dateBeasted, forKey: "date")
            beastedBeast.setValue(doneBeasted, forKey: "beasted")
            try context.save()
            print("Success, \(beastedBeast) beasted!")
            print(beastedBeast.beasted)
        } catch {
            print("Failure to save: \(error)")
        }
        unBeastedBeasts.remove(at: row)
        fetchUnBeastedBeasts()
        tableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return unBeastedBeasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ToBeastCustomCell = tableView.dequeueReusableCell(withIdentifier: "ToBeastCustomCell", for: indexPath) as! ToBeastCustomCell
        cell.cellDelegate = self
        // Configure the cell...

        cell.taskLabel.text = unBeastedBeasts[indexPath.row].task
        let size = CGSize(width: 90, height: 90)
        cell.beastButton.sizeThatFits(size)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "JustBeastIt", sender: (indexPath as NSIndexPath).row)
        print("selected")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let beastObject = unBeastedBeasts.remove(at: indexPath.row)
        context.delete(beastObject)
        do {
            try context.save()
            print("\(beastObject) deleted")
        } catch {
            print("Error in deleting \(beastObject)")
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        fetchUnBeastedBeasts()
        tableView.reloadData()
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let controller = navController.topViewController as! JustBeastItTableViewController
        controller.cancelDelegate = self
        controller.beastDelegate = self
        if let currentSender = sender as? Int {
            if currentSender > -1 {
                controller.beastToEdit = unBeastedBeasts[currentSender]
                controller.beastToEditIndexPathRow = currentSender
                print("Sender is a tableView cell")
            } else {
                print("Sender is the add button")
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

}
