//
//  ViewController.swift
//  Glyph
//
//  Created by Paige Plander on 6/20/15.
//

import UIKit

/// View controller for the Settings page within the app
class SettingsViewController: UITableViewController {
    
    /// Button for adding a new icon tile
    @IBOutlet weak var addButton: UIButton!
    
    /// The navigation bar for the settings page
    @IBOutlet weak var settingsNavBar: UINavigationBar!
    
    /// The back button for the settings page (returns to the main view controller)
    @IBOutlet weak var settingsBackButton: UIBarButtonItem!

    var data = DataModel(isNewEmptyDataModel: false)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    /// Switch allowing users to toggle between basic tiles mode and regular tiles mode
    @IBOutlet weak var basicModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let basicModeSwitchState = userDefaults.boolForKey("basicMode")
        basicModeSwitch.setOn(basicModeSwitchState, animated: false)
        basicModeSwitch.addTarget(self, action: #selector(SettingsViewController.stateChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Toggles between basic and regular mode for the tiles view
     
     - parameter switchState: If on, sets the mode to basic mode (else normal mode)
     */
    func stateChanged(switchState: UISwitch) {
        if basicModeSwitch.on {
            userDefaults.setBool(true, forKey: "basicMode")
        } else {
            userDefaults.setBool(false, forKey: "basicMode")
        }
    }
    
    /**
     Returns the user either to the basic tiles view of regular tiles view
     
     - parameter sender: The button that triggers the action
     */
    @IBAction func backButton(sender: UIButton) {
        if basicModeSwitch.on {
            performSegueWithIdentifier("settingsToBasic", sender: self)
        } else {
            performSegueWithIdentifier("settingsToMain", sender: self)
        }
    }
}
