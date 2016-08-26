//
//  FolderTableViewController.swift
//  Glyph
//
//  Created by Paige Plander on 1/6/16.
//  Copyright © 2016 Paige Plander. All rights reserved.
//

import UIKit
import Foundation

/// Controller for the Folder Table View that allows users to toggle between folders
class FolderTableViewController: UITableViewController {
    
    /// Array of the available folders (default is the "General" folder)
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
}
