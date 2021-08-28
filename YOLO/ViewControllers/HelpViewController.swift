

//  HelpViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 15/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit


class HelpViewController: UIViewController {
    @IBOutlet weak var tblHelp:UITableView!
    
    var arrSelect = [Bool]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblHelp.rowHeight = UITableView.automaticDimension
        self.tblHelp.estimatedRowHeight = 52.0
        
        for _ in 0..<20 {
            arrSelect.append(false)
        }
        tblHelp.reloadData()
    }
    
}

extension HelpViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return arrSelect[indexPath.row] ? UITableView.automaticDimension : 52
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSelect.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HelpTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        cell.imgArrow.image = arrSelect[indexPath.row] ? UIImage (named:"helpUp") : UIImage (named:"downHelp")
        cell.topDesc.constant = arrSelect[indexPath.row] ? 16 : 0
        cell.bottomDesc.constant = arrSelect[indexPath.row] ? 16 : 0
        cell.lblDescription.isHidden = !arrSelect[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<arrSelect.count {
            if indexPath.row == i {
                if arrSelect[i] {
                    arrSelect[i] = false
                } else {
                    arrSelect[i] = true
                }
            } else {
                arrSelect[i] = false
            }
        }
        tblHelp.reloadData()
    }
    
}
