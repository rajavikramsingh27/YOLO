//
//  ProfileTableViewCell.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 27/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var imgProfileICon:UIImageView!
    @IBOutlet weak var lblProfileText:UILabel!
    @IBOutlet weak var btnSelectProfile:UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
