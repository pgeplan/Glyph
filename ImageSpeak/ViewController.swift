//
//  ViewController.swift
//  ImageSpeak
//
//  Created by Paige Plander on 6/20/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var settingsNavBar: UINavigationBar!
    @IBOutlet weak var settingsNavItem: UINavigationItem!
    @IBOutlet weak var settingsBackButton: UIBarButtonItem!
    var data = DataModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Settings" {
            var destination = segue.destinationViewController as! SettingsModalViewController
            destination.data = data
        } else if segue.identifier == "backToMain" {
            var destination = segue.destinationViewController as! MainViewController
            destination.data = data
        } else if segue.identifier == "Remove" {
            var destination = segue.destinationViewController as! RemoveViewController
            destination.data = data
        }
        
        
    }

}

