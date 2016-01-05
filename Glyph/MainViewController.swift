//
//  MainViewController.swift
//  Glyph
//
//  Created by Anwar Baroudi on 6/21/15.
//

import Foundation
import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet weak var navBarSettingsButton: UIBarButtonItem!
    @IBOutlet weak var mainCollection: UICollectionView!
    //data source for the collectionView
    var data = DataModel(isNewEmptyDataModel: false)
    var filteredData = DataModel(isNewEmptyDataModel: true)
    var tempData = DataModel(isNewEmptyDataModel: true)
    var dataToFilter: [Int] = []
    
    //cell margin stuff
    var itemsPerPage = 0
    
    //the ultimate spacing variable, play with this if you want different margins
    var spaceBetweenCells: CGFloat = 15
    //minimum size of any cell
    var sizeOfCells = CGSize(width: 100.0, height: 120.0)
    
    //using for scrolling
    var currentScroll = 0
    var maxScroll = 0
    var currentX: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if mainCollection != nil {
            mainCollection.reloadData()
            let width = mainCollection.frame.width
            let height = mainCollection.frame.height
            itemsPerPage = Int(floor(width / CGFloat(100.0))) * Int(floor(height / CGFloat(120.0)))
            maxScroll = Int(ceil(Double(data.count) / Double(itemsPerPage)))
            
            
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //checking if we just came from the filter menu and have to filter stuff
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
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        cell.textLabel.layer.cornerRadius = 5
        cell.textLabel.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            let width = mainCollection.frame.width
            var itemsPerRow = 2
            var addedWidth = CGFloat(0.0)
            var leftover: CGFloat
            while (addedWidth == 0) {
                leftover = width - (CGFloat(itemsPerRow * 100) + CGFloat(itemsPerRow + 1) * spaceBetweenCells)
                if leftover < CGFloat(100) + spaceBetweenCells {
                    addedWidth = leftover / CGFloat(itemsPerRow)
                } else {
                    itemsPerRow += 1
                }
            }
            let finalWidth = 100 + addedWidth
            let finalHeight = finalWidth * 1.2
            let size = CGSize(width: finalWidth, height: finalHeight)
            sizeOfCells = size
            return size
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        setTempData()
        tempData.speakAtIndex(indexPath.row)
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        let sectionInset = UIEdgeInsets(top: spaceBetweenCells, left: spaceBetweenCells, bottom: spaceBetweenCells, right: spaceBetweenCells)
        mainCollection.contentInset = sectionInset
        return spaceBetweenCells
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
            return spaceBetweenCells
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