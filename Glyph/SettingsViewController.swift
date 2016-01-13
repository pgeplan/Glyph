//
//  ViewController.swift
//  Glyph
//
//  Created by Paige Plander on 6/20/15.
//

import UIKit

class SettingsViewController: UITableViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var settingsNavBar: UINavigationBar!
    @IBOutlet weak var settingsNavItem: UINavigationItem!
    @IBOutlet weak var settingsBackButton: UIBarButtonItem!
    var data = DataModel(isNewEmptyDataModel: false)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    @IBOutlet weak var basicModeSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let basicModeSwitchState = userDefaults.boolForKey("basicMode")
        basicModeSwitch.setOn(basicModeSwitchState, animated: false)
        basicModeSwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //basicModeSwitch action
    func stateChanged(switchState: UISwitch) {
        if basicModeSwitch.on {
            userDefaults.setBool(true, forKey: "basicMode")
        } else {
            userDefaults.setBool(false, forKey: "basicMode")
        }
    }
    
    @IBAction func backButton(sender: UIButton) {
        if basicModeSwitch.on {
            performSegueWithIdentifier("settingsToBasic", sender: self)
        } else {
            performSegueWithIdentifier("settingsToMain", sender: self)
        }
    }
    
    
}
