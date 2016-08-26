//
//  AddFolderViewController.swift
//  Glyph
//
//  Created by Paige Plander on 1/7/16.
//  Copyright © 2016 Paige Plander. All rights reserved.
//

import UIKit

/// View Controller for the view that allows users to add new folders
class AddFolderViewController: UIViewController {
    
    /// The user's folders (if none, default to a single "General" folder)
    var folders: [String] = NSUserDefaults.standardUserDefaults().arrayForKey("folders") as? [String] ?? ["General"]
    
    /// Text field for the folder's name
    @IBOutlet weak var folderTextField: UITextField!
    
    /**
     Creates a folder with the text provided from the user in the `folderTextField`
     
     - parameter sender: The button to add the folder
     */
    @IBAction func addFolder(sender: UIButton) {
        if let text = folderTextField.text {
            folders += [text]
            NSUserDefaults.standardUserDefaults().setObject(folders, forKey: "folders")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillLayoutSubviews()
        let size = CGSize(width: 450, height: folderTextField.frame.height + 70)
        self.preferredContentSize = size
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
