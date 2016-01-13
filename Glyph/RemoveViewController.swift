//
//  RemoveViewController.swift
//  Glyph
//
//  Created by Paige Plander on 6/21/15.
//

import Foundation
import UIKit

class RemoveViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if mainCollection != nil {
            mainCollection.reloadData()
            let width = mainCollection.frame.width
            let height = mainCollection.frame.height
            itemsPerPage = Int(floor(width / CGFloat(100.0))) + Int(floor(height / CGFloat(100.0)))
            maxScroll = Int(ceil(Double(data.count) / Double(itemsPerPage)))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setTempData()
        return tempData.countForFolder(folder)
    }
    

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = self.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! BasicCollectionCell
        
        let removeActionHandler = { (action:UIAlertAction!) -> Void in
            self.data.remove(self.folder, labelName: cell.textLabel.text!)
            self.mainCollection.deleteItemsAtIndexPaths([indexPath])
            
            //collectionView.deleteItemsAtIndexPaths([indexPath])
            
            self.mainCollection.reloadData()
        
        }
        
        let alertController = UIAlertController(title: "Remove Icon", message: "Delete this Icon?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.Default,handler: removeActionHandler))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func doneButton(sender: UIButton) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let basic = userDefaults.boolForKey("basicMode")
        if basic {
            performSegueWithIdentifier("removeToBasic", sender: self)
        } else {
            performSegueWithIdentifier("removeToMain", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Executes if we are in Basic Mode
        if let destination = segue.destinationViewController as? MainViewController {
            destination.data = data
        }
        
        // Executes if we are in normal mode
        else {
            let tabBarDest = segue.destinationViewController as? UITabBarController
            let cardsDest = tabBarDest?.viewControllers![0] as? MainViewController
            cardsDest?.data = data
        }
    }
}




