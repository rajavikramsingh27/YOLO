//
//  SettingsTableViewCell.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 14/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgIcon:UIImageView!
    @IBOutlet weak var lblTitles:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
