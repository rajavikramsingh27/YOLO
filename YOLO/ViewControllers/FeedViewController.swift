

//  FeedViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 10/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import SDWebImage


class FeedViewController: UIViewController {
    
    @IBOutlet weak var tblFeed:UITableView!
    
    var isPaging = false
    var page = 1
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        funcRefreshControl()
        funcCampaignsActive()
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
        tblFeed.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        arrFeed.removeAll()
        tblFeed.reloadData()
        
        page = 1
        funcCampaignsActive()
    }
    
    func funcCampaignsActive() {
        let loader = showLoader()
        APIFunc.getAPI("get/feed?page=\(page)", [:]) { (json) in
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
                            if self.isPaging {
                                let arrFeedNextPage = try decoder.decode([Feed].self, from: jsonData)
                                arrFeed = arrFeed+arrFeedNextPage
                            } else {
                                arrFeed = try decoder.decode([Feed].self, from: jsonData)
                            }
                            
                            DispatchQueue.main.async {
                                self.tblFeed.reloadData()
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
    
}



extension FeedViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 411
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedTableViewCell
        
        cell.imgUserProfile.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgUserProfile.sd_setImage(with: URL(string:(arrFeed[indexPath.row].user?.profile)!),
                                      placeholderImage:UIImage (named:""))
        cell.imgMedia.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgMedia.sd_setImage(with: URL(string:arrFeed[indexPath.row].media!),
                                      placeholderImage:UIImage (named:""))
        cell.imgSticker.sd_imageIndicator = SDWebImageActivityIndicator.white
        cell.imgSticker.sd_setImage(with: URL(string:arrFeed[indexPath.row].sticker!),
                                      placeholderImage:UIImage (named:"shareBG"))
        
        cell.lblUserName.text = arrFeed[indexPath.row].user?.fullName
        cell.lblHumanReadableTime.text = arrFeed[indexPath.row].humanReadableTime
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let arrayOfVisibleItems = tblFeed.indexPathsForVisibleRows
        let lastIndexPath = arrayOfVisibleItems?.last
        
        if let lastIndex = lastIndexPath {
            if lastIndex.row == arrFeed.count-1 {
                isPaging = true
                page += 1
                funcCampaignsActive()
            }
        }
    }
    
    @IBAction func btnSelect(_ sender:UIButton) {
//        pushViewController("MyCompaignDetailsViewController",k_MainStoryBoad)
    }
    
}


