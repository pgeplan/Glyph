//
//  RemoveViewController.swift
//  Glyph
//
//  Created by Paige Plander on 6/21/15.
//

import Foundation
import UIKit

class RemoveViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarSettingsButton: UIBarButtonItem!
    @IBOutlet weak var mainCollection: UICollectionView!
    var data = DataModel(isNewEmptyDataModel: false)
    var currentScroll = 0
    var maxScroll = 0
    var itemsPerPage = 0
    
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("basic1", forIndexPath: indexPath) as! BasicCollectionCell
        cell.imageView?.image = data.getImage(indexPath.row)
        cell.textLabel.text = data.getLabel(indexPath.row)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let removeActionHandler = { (action:UIAlertAction!) -> Void in
            self.data.remove(indexPath.row)
            self.mainCollection.deleteItemsAtIndexPaths([indexPath])
            //            self.mainCollection.reloadData()
        }
        
        let alertController = UIAlertController(title: "Remove Icon", message: "Delete this Icon?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Remove", style: UIAlertActionStyle.Default,handler: removeActionHandler))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        let width = mainCollection.frame.width
        let width2 = mainCollection.bounds.size.width
        var itemsPerHorizontalRow: Int = Int(floor(width / CGFloat(100.0)))
        var leftover = width % CGFloat(100.0)
        if leftover < CGFloat(30) {
            itemsPerHorizontalRow -= 1
            leftover += CGFloat(100.0)
        }
        print(leftover / CGFloat(itemsPerHorizontalRow))
        return leftover / CGFloat(itemsPerHorizontalRow)
        
    }
    
    @IBAction func scrollRight(sender: UIButton) {
        if currentScroll < maxScroll {
            currentScroll += 1
        }
        let width = mainCollection.frame.width
        let width2 = mainCollection.bounds.size.width
        let height = mainCollection.frame.height
        let height2 = mainCollection.bounds.size.width
        var newPoint = CGPoint(x: width * CGFloat(currentScroll), y: 0.0)
        mainCollection.setContentOffset(newPoint, animated: false)
    }
    
    @IBAction func scrollLeft(sender: UIButton) {
        if currentScroll > 0 {
            currentScroll -= 1
        }
        let width = mainCollection.frame.width
        let width2 = mainCollection.bounds.size.width
        let height = mainCollection.frame.height
        let height2 = mainCollection.bounds.size.width
        var newPoint = CGPoint(x: width * CGFloat(currentScroll), y: 0.0)
        mainCollection.setContentOffset(newPoint, animated: false)
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! MainViewController
        destination.data = data
    }
}




