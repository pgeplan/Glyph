//
//  FilterViewController.swift
//  Glyph
//
//  Created by Anwar Baroudi on 7/18/15.
//

import Foundation
import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var filterCollection: UICollectionView!
    var data = DataModel(isNewEmptyDataModel: false)
    var filteredData = DataModel(isNewEmptyDataModel: true)
    var dataToFilter: [Int] = []
    @IBOutlet var navBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if filterCollection != nil {
            filterCollection.reloadData()
        }
        navBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        // Sets shadow (line below the bar) to a blank image
        navBar.shadowImage = UIImage()
        // Sets the translucent background color
        navBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0)
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        navBar.translucent = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("filter", forIndexPath: indexPath) as! SelectableCell
        cell.imageView.image = data.getImage(indexPath.row)
        cell.textLabel.text = data.getLabel(indexPath.row)
        if contains(dataToFilter, indexPath.row) {
            cell.checkmarked.image = UIImage(named: "checkMark.png")
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if contains(dataToFilter, indexPath.row) {
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
        println(dataToFilter)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! MainViewController
        if segue.identifier == "FilterToMain" {
            makeFilteredDataArray()
            destination.dataToFilter = dataToFilter
        }
        else if segue.identifier == "CancelFilterToMain" {
            // Do Nothing (May need to change)
        }
        destination.filteredData = filteredData
        //        destination.data = data
        
    }
    
    private func makeFilteredDataArray() -> Void {
        for i in dataToFilter {
            filteredData.add(data.getImage(i), label: data.getLabel(i))
        }
    }
    
    
    
    
}