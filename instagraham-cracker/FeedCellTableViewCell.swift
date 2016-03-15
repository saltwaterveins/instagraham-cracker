//
//  FeedCellTableViewCell.swift
//  instagraham-cracker
//
//  Created by Stef Epp on 3/13/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit

class FeedCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var FeedLabel: UILabel!
    @IBOutlet weak var feedImages: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
