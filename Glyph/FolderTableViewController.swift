//
//  FolderTableViewController.swift
//  Glyph
//
//  Created by Paige Plander on 1/6/16.
//  Copyright © 2016 Paige Plander. All rights reserved.
//

import UIKit
import Foundation

class FolderTableViewController: UITableViewController {

    
   
    var folders = ["General"]
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    //breaking rules here, need to learn how to properly do this...
    var source = MainViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if userDefaults.arrayForKey("folders") == nil {
            userDefaults.setObject(folders, forKey: "folders")
        } else {
            folders = userDefaults.arrayForKey("folders") as! [String]
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillLayoutSubviews()
        let size = CGSize(width: 200, height: 200)
        self.preferredContentSize = size
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return folders.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("folderCell", forIndexPath: indexPath)
        let folderCell = cell as! FolderTableViewCell
        folderCell.folderLabel.text = folders[indexPath.row]
        
        // Configure the cell...

        return folderCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        userDefaults.setValue(folders[indexPath.row], forKey: "currentFolder")
        source.folderChanged = true
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
