//
//  MainViewController.swift
//  Glyph
//
//  Created by Anwar Baroudi on 6/21/15.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarSettingsButton: UIBarButtonItem!
    @IBOutlet weak var mainCollection: UICollectionView!
    
    
    var data = DataModel()
    var filteredData = DataModel()
    var tempData = DataModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        if mainCollection != nil {
            mainCollection.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTempData() -> Void {
        if filteredData.isEmpty() {
            tempData = data
        }
        else {
            tempData = filteredData
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        setTempData()
        return tempData.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        setTempData()
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("basic1", forIndexPath: indexPath) as! BasicCollectionCell
        cell.imageView?.image = tempData.getImage(indexPath.row)
        cell.textLabel.text = tempData.getLabel(indexPath.row)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        setTempData()
        tempData.speakAtIndex(indexPath.row)
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "MainToSettings" {
            let destination = segue.destinationViewController as! SettingsViewController
            destination.data = data
        }
        // Need to add to this once Anwar finishes Filter
        else if segue.identifier == "MainToFilter" {
            let destination = segue.destinationViewController as! FilterViewController
            destination.data = data
        }

        
    }
    
}
