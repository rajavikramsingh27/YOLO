//
//  FeedTableViewCell.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 10/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var lblUserName:UILabel!
    @IBOutlet weak var lblHumanReadableTime:UILabel!
    @IBOutlet weak var imgUserProfile:UIImageView!
    @IBOutlet weak var imgMedia:UIImageView!
    @IBOutlet weak var imgSticker:UIImageView!
    @IBOutlet weak var btnSelect:UIButton!
    @IBOutlet weak var imgNGO_Logo:UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
