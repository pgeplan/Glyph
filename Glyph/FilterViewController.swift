//
//  FilterViewController.swift
//  Glyph
//
//  Created by Anwar Baroudi on 7/18/15.
//  Copyright (c) 2015 Paige Plander. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var filterCollection: UICollectionView!
    var data = DataModel(isNewEmptyDataModel: false)
    var filteredData = DataModel(isNewEmptyDataModel: true)
    var dataToFilter: [Int] = []
    var currentScroll = 0
    var maxScroll = 0
    var itemsPerPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if filterCollection != nil {
            filterCollection.reloadData()
            let width = filterCollection.frame.width
            let height = filterCollection.frame.height
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
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        let width = filterCollection.frame.width
        let width2 = filterCollection.bounds.size.width
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
        let width = filterCollection.frame.width
        let width2 = filterCollection.bounds.size.width
        let height = filterCollection.frame.height
        let height2 = filterCollection.bounds.size.width
        var newPoint = CGPoint(x: width * CGFloat(currentScroll), y: 0.0)
        filterCollection.setContentOffset(newPoint, animated: false)
    }
    
    @IBAction func scrollLeft(sender: UIButton) {
        if currentScroll > 0 {
            currentScroll -= 1
        }
        let width = filterCollection.frame.width
        let width2 = filterCollection.bounds.size.width
        let height = filterCollection.frame.height
        let height2 = filterCollection.bounds.size.width
        var newPoint = CGPoint(x: width * CGFloat(currentScroll), y: 0.0)
        filterCollection.setContentOffset(newPoint, animated: false)
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