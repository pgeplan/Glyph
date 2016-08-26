//
//  FolderTableViewCell.swift
//  Glyph
//
//  Created by Paige Plander on 1/6/16.
//  Copyright © 2016 Paige Plander. All rights reserved.
//

import UIKit

/// Table view cell for the `FolderTableView`
class FolderTableViewCell: UITableViewCell {

    /// Label displaying the given folder's title
    @IBOutlet weak var folderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
