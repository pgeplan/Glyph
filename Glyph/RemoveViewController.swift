//
//  RemoveViewController.swift
//  Glyph
//
//  Created by Paige Plander on 6/21/15.
//

import Foundation
import UIKit

/// View Controller for the view displayed when the user wants to delete an icon
class RemoveViewController: TilesViewController {

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
            
            if let cellText = cell.textLabel.text {
                self.data.remove(self.folder, tile: Tile(tileName: cellText, tileImage: UIImage(), folderName: self.folder))
            }
            self.mainCollection.deleteItemsAtIndexPaths([indexPath])
            self.mainCollection.reloadData()
        
        }
        let alertController = UIAlertController(title: "Remove Icon", message: "Delete this Icon?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.Default,handler: removeActionHandler))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /**
     Button pressed when the user is finished removing icons. Pressing this
     button brings the user back to the main tiles screen.
     
     - parameter sender: The done button
     */
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
        if let destination = segue.destinationViewController as? TilesViewController {
            destination.data = data
        }
        // Executes if we are in normal mode
        else {
            let tabBarDest = segue.destinationViewController as? UITabBarController
            let cardsDest = tabBarDest?.viewControllers![0] as? TilesViewController
            cardsDest?.data = data
        }
    }
}
