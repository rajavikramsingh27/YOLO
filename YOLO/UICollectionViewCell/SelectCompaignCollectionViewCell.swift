//
//  SelectCompaignCollectionViewCell.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 23/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class SelectCompaignCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var btnSelect:UIButton!
    
    @IBOutlet weak var percent: MBCircularProgressBarView!
    @IBOutlet weak var imgThumpnail:UIImageView!
    @IBOutlet weak var imgNGO_Logo:UIImageView!
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblDaysLeft:UILabel!
}
