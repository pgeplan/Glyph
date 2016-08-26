//
//  BasicModeTilesViewController.swift
//  Glyph
//
//  Created by Anwar Baroudi on 6/21/15.
//

import Foundation
import UIKit

// Similar to the Main Tiles View, except replaces scrolling with left/right buttons
class BasicModeTilesViewController: TilesViewController {
    
    /// Button that updates the scroll offset to the right
    @IBOutlet weak var scrollButtonRight: UIButton!
    
    /**
     Scrolls the collection view's content over to the right (forwards).
     
     - parameter sender: The right button at the bottom of the screen
     */
    @IBAction func scrollRight(sender: UIButton) {
        if currentScroll < maxScroll {
            currentScroll += 1
        } else {
            return
        }
        let width = mainCollection.frame.width
        var newPoint = CGPoint(x: CGFloat(0), y: CGFloat(0))
        if currentScroll == 1 {
            currentX = width * CGFloat(currentScroll) - spaceBetweenCells*2
            newPoint = CGPoint(x: currentX, y: 0.0)
        } else {
            currentX = currentX + width - spaceBetweenCells
            newPoint = CGPoint(x: currentX, y: 0.0)
        }
        mainCollection.setContentOffset(newPoint, animated: false)
    }
    
    /**
     Scrolls the collection view's content over to the left (backwards).
     
     - parameter sender: The left button at the bottom of the screen
     */
    @IBAction func scrollLeft(sender: UIButton) {
        if currentScroll > 0 {
            currentScroll -= 1
        } else {
            return
        }
        let width = mainCollection.frame.width
        var newPoint = CGPoint(x: CGFloat(0), y: CGFloat(0))
        currentX = currentX - width + spaceBetweenCells
        newPoint = CGPoint(x: currentX, y: 0.0)
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
