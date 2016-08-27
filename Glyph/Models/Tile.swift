//
//  Tile.swift
//  Glyph
//
//  Created by Paige Plander on 8/26/16.
//  Copyright © 2016 Paige Plander. All rights reserved.
//

import UIKit

/// Model for a tile (each tile displays a image and image name)
class Tile: NSObject, NSCoding {
    
    /// The name of the tile (when the tile is tapped, this name is spoken out by the app)
    let tileName: String
    
    /// The image for this icon tile
    let tileImage: UIImage
    
    /// The name of the folder that this icon belongs to
    let folderName: String
 
    /**
     Designated initializer for a Tile object
     
     - parameter tileName:   The text to be displayed in the tile's label
     - parameter tileImage:  The image for this icon tile
     - parameter folderName: The name of the folder that this icon belongs to
     
     - returns: An initialized `Tile` object.
     */
    required init(tileName: String, tileImage: UIImage, folderName: String) {
        self.tileName = tileName
        self.tileImage = tileImage
        self.folderName = folderName
        super.init()
    }
    
    /**
     Convenience initializer for making an empty tile. Ideally, we should never need to 
     make one of these, so we should take this out eventually.
     
     - returns: An empty tile
     */
    convenience override init() {
        self.init(tileName: "", tileImage: UIImage(), folderName: "")
    }
    
    /// MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
    
    // NS_DESIGNATED_INITIALIZER
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    /// Makes printing out tiles pretty
    override var description: String {
        let tileToString = "Tile(" + tileName + ": " + folderName + ")"
        return tileToString
    }
}
