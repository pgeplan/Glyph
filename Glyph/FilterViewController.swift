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
    var data = DataModel()
    var filteredData = DataModel()
    var dataToFilter: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if filterCollection != nil {
            filterCollection.reloadData()
        }
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
            cell.checkmarked.image = UIImage(named: "checkFromNet.png")
            dataToFilter.append(indexPath.row)
        }
        collectionView.deselectItemAtIndexPath(indexPath, animated: false)
        println(dataToFilter)
    }
    
    
}