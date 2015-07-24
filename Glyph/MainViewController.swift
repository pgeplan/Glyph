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
    
    @IBOutlet weak var scrollButtonRight: UIButton!
    var data = DataModel(isNewEmptyDataModel: false)
    var filteredData = DataModel(isNewEmptyDataModel: true)
    var tempData = DataModel(isNewEmptyDataModel: true)
    var dataToFilter: [Int] = []
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
//        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "timerDidFire", userInfo: nil, repeats: false)
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
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
        
        if segue.identifier == "MainToSettings" {
            //            let destination = segue.destinationViewController as! SettingsViewController
            //            destination.data = data
        }
            // Need to add to this once Anwar finishes Filter
        else if segue.identifier == "MainToFilter" {
            let destination = segue.destinationViewController as! FilterViewController
            destination.data = data
            destination.dataToFilter = dataToFilter
        }
        
        
    }
    
}