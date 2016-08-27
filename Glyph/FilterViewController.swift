//
//  FilterViewController.swift
//  Glyph
//
//  Created by Anwar Baroudi on 7/18/15.
//  Copyright (c) 2015 Paige Plander. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: TilesViewController {
    @IBOutlet weak var filterCollection: UICollectionView!

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
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        setTempData()
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("basic1", forIndexPath: indexPath) as! SelectableCell
        cell.imageView?.image = tempData.getImage(indexPath.row, folder: folder)
        cell.textLabel.text = tempData.getLabel(indexPath.row, folder: folder)
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        cell.textLabel.layer.cornerRadius = 5
        cell.textLabel.layer.masksToBounds = true
   
        if dataToFilter.contains(indexPath.row) {
            cell.checkmarked.image = UIImage(named: "checkMark.png")
        }
        
        return cell
    }
    
    override  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if dataToFilter.contains(indexPath.row) {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SelectableCell
            cell.checkmarked.image = nil
            var counter = 0
            while counter < dataToFilter.count {
                if dataToFilter[counter] == indexPath.row {
                    dataToFilter.removeAtIndex(counter)
                    counter -= 1
                }
                counter += 1
            }
        } else {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SelectableCell
            cell.checkmarked.image = UIImage(named: "checkMark.png")
            dataToFilter.append(indexPath.row)
        }
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        print(dataToFilter)
    }
    


    @IBAction func cancelButtonAction(sender: UIBarButtonItem) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let basic = userDefaults.boolForKey("basicMode")
        if basic {
            performSegueWithIdentifier("cancelFilterToBasic", sender: self)
        } else {
            performSegueWithIdentifier("cancelFilterToMain", sender: self)
        }
    }
    
    @IBAction func filterButtonAction(sender: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let basic = userDefaults.boolForKey("basicMode")
        if basic {
            performSegueWithIdentifier("filterToBasic", sender: self)
        } else {
            performSegueWithIdentifier("filterToMain", sender: self)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "filterToMain" {
            let tempDestination = segue.destinationViewController as! UITabBarController
            let destination = (tempDestination.viewControllers![0] as? TilesViewController)!
            makeFilteredDataArray()
            destination.dataToFilter = dataToFilter
            destination.filteredData = filteredData
        } else if segue.identifier == "filterToBasic" {
            let destination = segue.destinationViewController as! BasicModeTilesViewController
            makeFilteredDataArray()
            destination.dataToFilter = dataToFilter
            destination.filteredData = filteredData
        }
        
    }
    
    private func makeFilteredDataArray() -> Void {
        for i in dataToFilter {
            let tile = Tile(tileName: data.getLabel(i, folder: folder), tileImage: data.getImage(i, folder: folder), folderName: folder)
            filteredData.addTile(tile)
        }
    }
}
