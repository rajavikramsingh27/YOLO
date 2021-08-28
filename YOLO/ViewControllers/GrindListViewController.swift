//
//  GrindListViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 06/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit
//import MBProgressHUD
//import SwiftMessageBar
import SDWebImage



class GrindListViewController: UIViewController {
    @IBOutlet weak var collDonnationList:UICollectionView!
    
//    var arrDonationTypeListIcons = ["workout","cycle","running","basketBall","soccer","tennis","golf","others"]
//    var arrDonationTypeListTitle = ["Workout","Cycling","Running","BasketBall","Soccer","Tennis","Golf","Others"]
    
    var arrDonnationTypeSelect = [Bool]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        funcGetGrinds()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        arrGetgrinds.removeAll()
    }
    
    func funcGetGrinds() {
        let loader = showLoader()
        APIFunc.getAPI("get/grinds", [:]) { (json) in
            DispatchQueue.main.async {
                self.hideLoader(loader)
                                
                if json.dictionaryObject == nil {
                    return
                }
                
                let status = return_status(json.dictionaryObject!)
                
                switch status {
                case .success:
                    let decoder = JSONDecoder()
                    if let jsonData = json["data"].description.data(using: .utf8) {
                        do {
                            arrGetgrinds = try decoder.decode([Getgrind].self, from: jsonData)
                            DispatchQueue.main.async {
                                for _ in 0..<arrGetgrinds.count {
                                    self.arrDonnationTypeSelect.append(false)
                                }
                                
                                self.collDonnationList.reloadData()
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                case .fail:
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.showAlert("\(json.dictionaryObject!["message"]!)", AlertType.error) { (alertAction) in
                            
                        }
                    })
                case .error_from_api:
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.showAlert("Error from API", AlertType.error) { (alertAction) in
                            
                        }
                    })
                }
            }
        }
    }
    
    @IBAction func btnProfile(_ sender:UIButton) {
        self.navigationController!.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selectedIndex"), object: nil)
    }

}



extension GrindListViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width/3-30
        return CGSize (width:width, height:width+40)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrGetgrinds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDonnationList", for: indexPath) as! DonnationTypeCollectionViewCell
        let width = self.view.frame.width/3-30
        
        cell.lblGrindName.text = arrGetgrinds[indexPath.row].name
        cell.imgCircle.layer.borderColor = UIColor.white.cgColor
        cell.imgCircle.layer.borderWidth = arrDonnationTypeSelect[indexPath.row] ? 0 : 2
        cell.imgCircle.layer.cornerRadius = width/2
        cell.imgCircle.clipsToBounds = true
        
        cell.imgCircle.sd_imageIndicator = SDWebImageActivityIndicator.gray
        cell.imgCircle.sd_setImage(with: URL(string:arrGetgrinds[indexPath.row].logo),
                                   placeholderImage:UIImage (named:""))
        
        cell.imgBG.isHidden = !arrDonnationTypeSelect[indexPath.row]
        
        cell.btnSelect.tag = indexPath.row
        cell.btnSelect.addTarget(self, action:#selector(btnDonnationTypeSelect), for: .touchUpInside)
        
        return cell
    }
    
    @IBAction func btnDonnationTypeSelect(_ sender:UIButton) {
        for i in 0..<arrDonnationTypeSelect.count {
            if i == sender.tag {
                arrDonnationTypeSelect[i] = true
            } else {
                arrDonnationTypeSelect[i] = false
            }
        }
        
        collDonnationList.reloadData()
        if let grindIDExist = arrGetgrinds[sender.tag].id as? Int {
            grindID = "\(grindIDExist)"
            pushViewController("CameraViewController", k_MainStoryBoad)
        }
        
    }
    
    
}
