

//  ProfileViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 27/11/20.
//  Copyright ©2020 Boons&Blessings Apps. All rights reserved.


import UIKit


class ProfileViewController: UIViewController {
    
    var arrProfileIcons = ["myComaign","myDonation","editProfile",
                           "paymentMethod","settings","shareFromProfile","Logout"]
    
    var arrProfileText = ["My Comaign","My Donation","Edit Profile",
    "Payment Method","Settings","Share","Logout"]
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    
    
}



extension ProfileViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProfileText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProfileTableViewCell
        
        cell.lblProfileText.text = arrProfileText[indexPath.row]
        cell.imgProfileICon.image = UIImage(named:arrProfileIcons[indexPath.row])
        
        cell.btnSelectProfile.tag = indexPath.row
        cell.btnSelectProfile .addTarget(self, action:#selector(btnSelectProfile(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func btnSelectProfile(_ sender:UIButton) {
        if sender.tag == 0 {
            pushViewController("MyComaignViewController", k_MainStoryBoad)
        } else if sender.tag == 1 {
            pushViewController("MyDonnaationViewController", k_MainStoryBoad)
        } else if sender.tag == 2 {
            pushViewController("EditProfileViewController", k_MainStoryBoad)
        } else if sender.tag == 4 {
            pushViewController("SettingsViewController", k_MainStoryBoad)
        } else if sender.tag == 5 {
            shareTextButton("Please download YOLO App to use this url")
        } else {
            self.navigationController!.viewControllers.removeAll()
            pushViewController("LoginViewController", k_MainStoryBoad)
        }
        
    }
    
    
}


