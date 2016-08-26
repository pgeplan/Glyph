//
//  BasicCollectionCell.swift
//  Glyph
//
//  Created by Anwar Baroudi on 6/21/15.
//

import Foundation
import UIKit

/// Collection View cell for the main "tiles" view
class BasicCollectionCell: UICollectionViewCell {
    
    /// The image view for the tile's image
    @IBOutlet weak var imageView: UIImageView!
    
    /// The text label for displaying the tile's text
    @IBOutlet weak var textLabel: UILabel!
}
