

//  SelectCompaignViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 23/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import SDWebImage


class SelectCompaignViewController: UIViewController {
    @IBOutlet weak var collCompaignList:UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        funcSelectCompaign()
    }
    
    
    @IBAction func btnProfile(_ sender:UIButton) {
        self.navigationController!.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selectedIndex"), object: nil)
    }
    
    func funcSelectCompaign() {
        let loader = showLoader()
        APIFunc.getAPI("get/campaigns", [:]) { (json) in
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
                            arrCompaignList = try decoder.decode([CompaignList].self, from: jsonData)
                            DispatchQueue.main.async {
                                self.collCompaignList.reloadData()
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
    
}



extension SelectCompaignViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collCompaignList.frame.width-90
        let height = (16*width)/9
        return CGSize (width:width, height:height)
        
//        return CGSize (width: frame.width-80, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrCompaignList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectCompaignCollectionViewCell
        
        cell.btnSelect.tag = indexPath.row
        cell.btnSelect.addTarget(self, action:#selector(btnSelect(_:)), for: .touchUpInside)
        
        cell.imgThumpnail.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgThumpnail.sd_setImage(with: URL(string:arrCompaignList[indexPath.row].thumbnail),
                                      placeholderImage:UIImage (named:""))
        
        cell.imgNGO_Logo.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgNGO_Logo.sd_setImage(with: URL(string:arrCompaignList[indexPath.row].ngo.logo!),
                                      placeholderImage:UIImage (named:""))
        
        cell.lblName.text = arrCompaignList[indexPath.row].name
        cell.lblDaysLeft.text = "\(arrCompaignList[indexPath.row].daysLeft) days left"
        
        cell.percent.value = CGFloat(arrCompaignList[indexPath.row].primaryGoalProgressPercentage)
        
        return cell
    }
    
    @IBAction func btnDismiss(_ sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSelect(_ sender:UIButton) {
        selectedComapaignID = "\(arrCompaignList[sender.tag].id)"
        pushViewController("CompaignDetailsViewController", k_MainStoryBoad)
    }
    
}
