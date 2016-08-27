//
//  FolderSettingsTableViewController.swift
//  Glyph
//
//  Created by Paige Plander on 1/7/16.
//  Copyright © 2016 Paige Plander. All rights reserved.
//

import UIKit

/// View controller for the view that presents the user with folder settings
class FolderSettingsTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var folders: [String] = NSUserDefaults.standardUserDefaults().arrayForKey("folders") as? [String] ?? ["General"]
    var data = DataModel(isNewEmptyDataModel: false)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItems? += [editButtonItem()]
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
        
        
        folderCell.folderLabel?.text = folders[indexPath.row]
        // Configure the cell...
        
        return folderCell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // called when a row is moved
    override func tableView(tableView: UITableView,
        moveRowAtIndexPath sourceIndexPath: NSIndexPath,
        toIndexPath destinationIndexPath: NSIndexPath) {
            // remove the dragged row's model
            let val = self.folders.removeAtIndex(sourceIndexPath.row)
            
            // insert it into the new position
            self.folders.insert(val, atIndex: destinationIndexPath.row)
    }
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            // Delete the row from the data source
            data.removeFolder(folders[indexPath.row])
            folders.removeAtIndex(indexPath.row)
            userDefaults.setObject(folders, forKey: "folders")
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier{
                case "AddFolderPopOver":
                    let popoverViewController = segue.destinationViewController as! AddFolderViewController
                    // disable modal view for iPhones
                    popoverViewController.modalPresentationStyle = UIModalPresentationStyle.Popover
                    popoverViewController.popoverPresentationController!.delegate = self
                default: break
            }
        }
    }
    
    // Delegate method of Popover Presenter Delegate
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}
