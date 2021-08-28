
//  HelpTableViewCell.swift
//  YOLO

//  Created by Boons&Blessings Apps on 15/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit


class HelpTableViewCell: UITableViewCell {
    @IBOutlet weak var imgArrow:UIImageView!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    
    @IBOutlet weak var topDesc:NSLayoutConstraint!
    @IBOutlet weak var bottomDesc:NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
