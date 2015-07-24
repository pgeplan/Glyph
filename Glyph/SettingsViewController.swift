//
//  SettingsViewController.swift
//  Glyph
//
//  Created by Paige Plander on 6/20/15.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var settingsNavBar: UINavigationBar!
    @IBOutlet weak var settingsNavItem: UINavigationItem!
    @IBOutlet weak var settingsBackButton: UIBarButtonItem!
    var data = DataModel(isNewEmptyDataModel: false)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "AddIcon" {
    //            let destination = segue.destinationViewController as! AddIconViewController
    //            destination.data = data
    //        } else if segue.identifier == "backToMain" {
    //            let destination = segue.destinationViewController as! MainViewController
    //            destination.data = data
    //        } else if segue.identifier == "Remove" {
    //            let destination = segue.destinationViewController as! RemoveViewController
    //            destination.data = data
    //        }
    //        
    //        
    //    }
    
}
