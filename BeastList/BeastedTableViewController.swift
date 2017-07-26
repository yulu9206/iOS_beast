//
//  BeastedTableViewController.swift
//  BeastList
//
//  Created by Lu Yu on 9/23/16.
//  Copyright © 2016 Lu Yu. All rights reserved.
//

import UIKit; import Foundation

class BeastedTableViewController: UITableViewController {
    
    var beasts = [Beast]()
    var beastedBeasts = [Beast]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchBeastedBeasts()
        beastedBeasts = [Beast]()
        appendBeasts(beasts: beasts)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchBeastedBeasts() {
        do {
            let results = try context.fetch(Beast.fetchRequest())
            beasts = results as! [Beast]
        } catch {
            print(error)
        }
    }
    
    func appendBeasts(beasts: [Beast]) {
        for beast in beasts {
            if beast.beasted == false {
                print("\(beast.task) is Beasted")
            } else {
                beastedBeasts.append(beast)
                print("\(beast.task) is UnBeasted")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return beastedBeasts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeastedTasks", for: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMMM yy"
        let convertedDate = dateFormatter.string(from: beastedBeasts[indexPath.row].date! as Date)
        cell.textLabel?.text = beastedBeasts[indexPath.row].task!
        cell.detailTextLabel?.text = convertedDate
        

        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let beastObject = beastedBeasts.remove(at: indexPath.row)
        context.delete(beastObject)
        do {
            try context.save()
            print("\(beastObject) deleted")
        } catch {
            print("Error in deleting \(beastObject)")
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        fetchBeastedBeasts()
        tableView.reloadData()
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
