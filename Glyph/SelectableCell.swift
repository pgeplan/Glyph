//
//  SelectableCell.swift
//  Glyph
//
//  Created by Anwar Baroudi on 7/18/15.
//  Copyright (c) 2015 Paige Plander. All rights reserved.
//

import Foundation
import UIKit

/// Collection View Cell for the "Filter" Collecton View
class SelectableCell: UICollectionViewCell {
    
    /// The text label for the tile
    @IBOutlet weak var textLabel: UILabel!
    
    /// The image view for the tile's image
    @IBOutlet weak var imageView: UIImageView!
    
    /// The image view for the check mark (the checkmark is visible if the tile is selected)
    @IBOutlet weak var checkmarked: UIImageView!
}
