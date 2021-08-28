//
//  SettingsViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 14/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    let arrTitles = ["About Us","Privacy Policy","Terms Of Service",
                     "Help","Contact Us","Rate Us"]
    
    let arrIcons = ["about","privacyPolicy","termsOfService","help","contactUs","rateUs"]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
}



extension SettingsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrIcons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        cell.imgIcon.image = UIImage (named: arrIcons[indexPath.row])
        cell.lblTitles.text = arrTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            pushViewController("AboutUsViewController", k_MainStoryBoad)
        } else if indexPath.row == 1 {
            pushViewController("PrivacyPolicyViewController", k_MainStoryBoad)
        } else if indexPath.row == 2 {
            pushViewController("TermsOfServiceViewController", k_MainStoryBoad)
        } else if indexPath.row == 3 {
            pushViewController("HelpViewController", k_MainStoryBoad)
        } else if indexPath.row == 4 {
            pushViewController("ContactUsViewController", k_MainStoryBoad)
        } else {
            rateApp()
        }
    }
    
}


