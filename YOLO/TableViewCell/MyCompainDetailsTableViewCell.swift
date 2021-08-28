
//  MyCompainDetailsTableViewCell.swift
//  YOLO

//  Created by Boons&Blessings Apps on 02/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import MBCircularProgressBar


class MyCompainDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var btnSelectProfile:UIButton!
    @IBOutlet weak var imgThumbnail:UIImageView!
    @IBOutlet weak var lblNameMeals:UILabel!
    @IBOutlet weak var lblDaysLeft:UILabel!
    @IBOutlet weak var imgNGO_Logo:UIImageView!
    @IBOutlet weak var percent: MBCircularProgressBarView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
