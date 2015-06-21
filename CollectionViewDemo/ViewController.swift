//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Anwar Baroudi on 6/20/15.
//  Copyright (c) 2015 Anwar Baroudi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet var collection: UICollectionView!

    
    
    let data: [String] = ["one.jpg", "two.jpg", "three.jpg", "four.jpg", "five.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()
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
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("hi", forIndexPath: indexPath) as! CollectionCell
        cell.iView?.image = UIImage(named: data[indexPath.row])
        return cell
        
    }
    

}

