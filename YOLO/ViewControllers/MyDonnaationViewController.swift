//
//  MyDonnaationViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 03/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit


class MyDonnaationViewController: UIViewController {
    
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



extension MyDonnaationViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrProfileText.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


