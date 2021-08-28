

//  MyComaignViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 29/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit


class MyComaignViewController:UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
        
    
    
}



extension MyComaignViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCompainDetailsTableViewCell
        
        cell.btnSelectProfile.addTarget(self, action:#selector(btnSelectProfile(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func btnSelectProfile(_ sender:UIButton) {
       pushViewController("MyCompaignDetailsViewController",k_MainStoryBoad)
    }
    
}

