

//  ActiveCompaignViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 10/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import SDWebImage


class ActiveCompaignViewController:UIViewController {
    
    @IBOutlet weak var tblActiveCompaign:UITableView!
    @IBOutlet weak var lblUserName:UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(funcSelectedIndex),
                                               name: NSNotification.Name.init(rawValue: "selectedIndex"), object: nil)
        
        funcRefreshControl()
        funcCampaignsActive()
    }
        
    @IBAction func btnPlust(_ sender:UIButton) {
        let tabbar = self.storyboard!.instantiateViewController(withIdentifier:"SelectCompaignViewController")
        tabbar.modalPresentationStyle = .fullScreen
        self.present(tabbar, animated: true, completion:nil)
    }
    
    var refreshControl = UIRefreshControl()
    
    func funcRefreshControl() {
        let myString = "Pull to refresh"
        let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.white,
                            NSAttributedString.Key.font: UIFont(name: "ProductSans-Bold", size: 16.0)!]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        refreshControl.attributedTitle = myAttrString
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblActiveCompaign.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        arrActiveCompaign.removeAll()
        tblActiveCompaign.reloadData()
        
        funcCampaignsActive()
    }

    func funcCampaignsActive() {
        funcProfile()
        
        let loader = showLoader()
        APIFunc.getAPI("get/campaigns/active", [:]) { (json) in
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
                            arrActiveCompaign = try decoder.decode([ActiveCompaign].self, from: jsonData)
                            DispatchQueue.main.async {
                                self.tblActiveCompaign.reloadData()
                                self.refreshControl.endRefreshing()
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
    
    func funcProfile() {
//        let loader = showLoader()
        APIFunc.getAPI("get/profile", [:]) { (json) in
            DispatchQueue.main.async {
//                self.hideLoader(loader)
                
                if json.dictionaryObject == nil {
                    return
                }
                
                let status = return_status(json.dictionaryObject!)
                
                switch status {
                case .success:
                    let decoder = JSONDecoder()
                    if let jsonData = json["data"].description.data(using: .utf8) {
                        do {
                            profile = try decoder.decode(Profile.self, from: jsonData)
                            
                            DispatchQueue.main.async {
                                self.lblUserName.text = profile?.fullName!
                                self.lblUserName.text = profile?.gender
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

extension ActiveCompaignViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = self.view.frame.width
        return (9*width)/16
//        return 210
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrActiveCompaign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCompainDetailsTableViewCell
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = backgroundView
        
        cell.imgNGO_Logo.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgNGO_Logo.sd_setImage(with: URL(string:arrActiveCompaign[indexPath.row].ngo.logo!),
                                      placeholderImage:UIImage (named:""))
        
        cell.imgThumbnail.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgThumbnail.sd_setImage(with: URL(string:arrActiveCompaign[indexPath.row].thumbnail),
                                      placeholderImage:UIImage (named:""))
        
        cell.lblNameMeals.text = "\(arrActiveCompaign[indexPath.row].name) \(arrActiveCompaign[indexPath.row].primaryGoalProgress) \(arrActiveCompaign[indexPath.row].goalUnit)"
        cell.lblDaysLeft.text = "\(arrActiveCompaign[indexPath.row].daysLeft)"
        
        cell.percent.value = CGFloat(arrActiveCompaign[indexPath.row].primaryGoalProgressPercentage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedComapaignID = "\(arrActiveCompaign[indexPath.row].id)"
        
        let compaignDetailsVC = self.storyboard!.instantiateViewController(withIdentifier:"CompaignDetailsViewController") as! CompaignDetailsViewController
        
        let navigationController = UINavigationController(rootViewController:compaignDetailsVC)
        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
}


