

//  CompaignDetailsViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 02/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import SDWebImage


var strGrinds = "10"
var strContributionID = ""


class CompaignDetailsViewController: UIViewController {
    @IBOutlet weak var scrollView:UIScrollView!
    @IBOutlet weak var pageControll:UIPageControl!
    @IBOutlet weak var collUpper:UICollectionView!
    @IBOutlet weak var collGrinds:UICollectionView!
    @IBOutlet weak var collMeals:UICollectionView!
    @IBOutlet weak var collAllDonner:UICollectionView!
    
    @IBOutlet weak var viewPledge:UIView!
    @IBOutlet weak var viewPledgeHeader:UIView!
    
    @IBOutlet weak var viewProgress:UIView!
    @IBOutlet weak var viewProgressHeader:UIView!
    
    @IBOutlet var arrImgSelected:[UIImageView]!
    @IBOutlet var arrLblSelectedText:[UILabel]!
    
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblMeals:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblDaysLeft:UILabel!
    @IBOutlet weak var lblPercent:UILabel!
    
    @IBOutlet weak var lblPrimaryGoalTarget:UILabel!
    @IBOutlet weak var lblPrimaryGoalProgress:UILabel!
    
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var btnReadMore:UIButton!
    
    @IBOutlet weak var progressView:UIProgressView!
    
    @IBOutlet weak var lbl2MealsForEveryGridn:UILabel!
    @IBOutlet weak var lblPerMealsUSD4:UILabel!
    @IBOutlet weak var viewDonner:UIView!
    @IBOutlet weak var heightReadWrite:NSLayoutConstraint!
    @IBOutlet weak var bottomReadWrite:NSLayoutConstraint!
//    @IBOutlet weak var btnStartADonation:UIButton!
    @IBOutlet weak var imgNGO_Logo:UIImageView!
    
    @IBOutlet weak var progressBarApple:UIProgressView!
    @IBOutlet weak var progressBarHealth:UIProgressView!
    
    @IBOutlet weak var heightMainView:NSLayoutConstraint!
    @IBOutlet weak var heightAllDonner:NSLayoutConstraint!
    @IBOutlet weak var heightViewProgress:NSLayoutConstraint!
    @IBOutlet weak var heightViewPledge:NSLayoutConstraint!
    
    @IBOutlet weak var lblGrindTotal:UILabel!
    @IBOutlet weak var lblGrindProcess:UILabel!
    @IBOutlet weak var lblMealsTotal:UILabel!
    @IBOutlet weak var lblMealsProcess:UILabel!
    @IBOutlet weak var lblTotalPrice:UILabel!
    
    var arrGrindsSelected = [Bool]()
    var arrGrindsValue = [String]()
    
    var arrMealsSelected = [Bool]()
    var arrMealsValue = [String]()
    
    var upperCollectionCount = 0
    
    let shorHeight:CGFloat = 1143
    let longHeight:CGFloat = 1310
    
    let shorHeight_1:CGFloat = 260
    let longHeight_1:CGFloat = 447
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBarApple.layer.cornerRadius = 5
        progressBarApple.clipsToBounds = true
        
        progressBarHealth.layer.cornerRadius = 5
        progressBarHealth.clipsToBounds = true
        
        compaignDetails = nil
        
        funcSet2MealsForEveryGrinds()
        
        progressView.layer.cornerRadius = 3.5
        progressView.clipsToBounds = true
        
        lblDescription.numberOfLines = 4
            
        scrollView.isHidden = true
        funcCompaignDetails()
        funcGetDonners()
    }
    
    @IBAction func btnProfile(_ sender:UIButton) {
        self.navigationController?.dismiss(animated:true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selectedIndex"), object: nil)
    }

    func funcSetData() {
        
        for i in 0..<arrImgSelected.count {
            if i == arrImgSelected.count-1 {
                arrImgSelected[i].isHidden = true
                arrLblSelectedText[i].textColor = UIColor .white
            } else {
                arrImgSelected[i].isHidden = false
                arrLblSelectedText[i].textColor = hexStringToUIColor("0FF707")
            }
        }
        
        if compaignDetails.gallery!.count == 0 {
            pageControll.numberOfPages = 1
            upperCollectionCount = 1
        } else {
            pageControll.numberOfPages = compaignDetails.gallery!.count
        }
        
        collUpper.reloadData()
        
        scrollView.isHidden = false
        for i in 1...500 {
            arrGrindsValue.append("\(i)")
            arrGrindsSelected.append((i==10) ? true : false)
            
            arrMealsValue.append("\(i)")
            arrMealsSelected.append((i==20) ? true : false)
        }
        
        collGrinds.reloadData()
        collMeals.reloadData()
        
        collGrinds.scrollToItem(at:IndexPath(item:9, section:0), at: .right, animated:true)
        collMeals.scrollToItem(at:IndexPath(item:19, section:0), at: .right, animated:true)
        
        if let _ = compaignDetails.myContribution {
            heightMainView.constant = shorHeight
            
            heightAllDonner.constant = shorHeight_1
            heightViewProgress.constant = shorHeight_1
            heightViewPledge.constant = shorHeight_1
            
            strContributionID = "\(compaignDetails.myContribution!.contributionID!)"
            lblMealsTotal.text = "of \(compaignDetails.myContribution!.goalGrinds!) Meals"
            lblMealsProcess.text = "\(compaignDetails.myContribution!.goalGrindProgress!)"
            
            lblGrindTotal.text = "of \(compaignDetails.myContribution!.goalUnits!) Grinds"
            lblGrindProcess.text = "\(compaignDetails.myContribution!.goalUnitProgress!)"
            let doubleUnitProgress = Double(Int(compaignDetails.myContribution!.goalGrindProgress!))
            lblTotalPrice.text = "\(doubleUnitProgress*compaignDetails.conversionFactor!)"
            
            progressBarApple.progress = Float((compaignDetails.myContribution?.goalUnitProgressPercentage)!)/Float(100)
            progressBarHealth.progress = Float((compaignDetails.myContribution?.goalGrindProgressPercentage)!)/Float(100)
            
            viewPledgeHeader.isHidden = true
            viewPledge.isHidden = true
        } else {
            viewProgressHeader.isHidden = true
            viewProgress.isHidden = true
            
            heightMainView.constant = longHeight
            
            heightAllDonner.constant = longHeight_1
            heightViewProgress.constant = longHeight_1
            heightViewPledge.constant = longHeight_1
        }
        
        collAllDonner.isHidden = true
        
        funcSet2MealsForEveryGrinds ()
        
//        MARK:- set from API
        lblName.text = compaignDetails.name
        lblMeals.text = "\(compaignDetails.primaryGoalTarget!) Grinds"
        lblDate.text = "\(compaignDetails.startDate!.appDefaultDate) - \(compaignDetails.endDate!.appDefaultDate)"
        
        lblPrimaryGoalTarget.text = "\(compaignDetails.primaryGoalTarget!)"
        lblPrimaryGoalProgress.text = "\(compaignDetails.primaryGoalProgress!)"
        lblDescription.text = compaignDetails.getgrindsDescription!
        lblDaysLeft.text = "\(compaignDetails.daysLeft!)"
        lblPercent.text = "\(Int64(compaignDetails.primaryGoalProgressPercentage!)) %"
        
        progressView.progress = Float(Int(compaignDetails.primaryGoalProgressPercentage!))/Float(100)
        lblPerMealsUSD4.text = "(Per meal $ \(compaignDetails.conversionFactor!))"
        viewDonner.isHidden = (compaignDetails.gallery!.count == 0) ? true : false
        
        strNGO_Logo = (compaignDetails.ngo?.logo)!
        imgNGO_Logo.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imgNGO_Logo.sd_setImage(with: URL(string:(compaignDetails.ngo?.logo)!),
                                placeholderImage:UIImage (named:""))
        
        let size = lblDescription.text?.sizeAccordingText(
            view.frame.size.width-50,
            UIFont (name:"ProductSans-Regular",size:15.0)!)
        
        btnReadMore.isHidden = (size!.height < CGFloat(50)) ? true : false
        
        if btnReadMore.isHidden {
            heightReadWrite.constant = 0
            bottomReadWrite.constant = 10
        }
        
    }
    
    func funcCompaignDetails() {
        let loader = showLoader()
        APIFunc.getAPI("get/campaign/\(selectedComapaignID)", [:]) { (json) in
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
                            compaignDetails = try decoder.decode(CompaignDetails.self, from: jsonData)
                            DispatchQueue.main.async {
                                self.funcSetData()
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
    
    func funcGetDonners() {
        let loader = showLoader()
        APIFunc.getAPI("get/donors/\(selectedComapaignID)", [:]) { (json) in
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
                            arrGetDonner = try decoder.decode([GetDonner].self, from: jsonData)
                            
                            DispatchQueue.main.async {
                                self.collAllDonner.reloadData()
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
    
    func funcPledge()  {
        let loader = showLoader()
        let param = [
            "campaign_id":"\(compaignDetails.id!)",
            "no_of_units":meals,
            "no_of_grinds":strGrinds] as [String : Any]
        
        APIFunc.postAPI_Header("pledge", param) { (json) in
            DispatchQueue.main.async {
                self.hideLoader(loader)
                
                if json.dictionaryObject == nil {
                    return
                }
                
                let status = return_status(json.dictionaryObject!)
                
                switch status {
                case .success:
                    strContributionID = "\(json.dictionaryObject!["contribution_id"]!)"
                    DispatchQueue.main.async {
                        self.pushViewController("GrindListViewController", k_MainStoryBoad)
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
    
    @IBAction func btnReadMore(_ sender:UIButton) {
        if lblDescription.numberOfLines == 4 {
            lblDescription.numberOfLines = 0
            btnReadMore.setTitle("Read less", for: .normal)
        } else {
            lblDescription.numberOfLines = 4
            btnReadMore.setTitle("Read more", for: .normal)
        }
    }
    
    @IBAction func btnMyPledgeAllDonner(_ sender:UIButton) {
        viewPledge.isHidden = true
        viewProgress.isHidden = true
        collAllDonner.isHidden = true
        
        if sender.tag == 1 {
            viewPledge.isHidden = false
        } else if sender.tag == 2 {
            viewProgress.isHidden = false
            
            heightMainView.constant = shorHeight
            
            heightAllDonner.constant = shorHeight_1
            heightViewProgress.constant = shorHeight_1
            heightViewPledge.constant = shorHeight_1
        } else {
            collAllDonner.isHidden = false
            
            heightMainView.constant = longHeight
            
            heightAllDonner.constant = longHeight_1
            heightViewProgress.constant = longHeight_1
            heightViewPledge.constant = longHeight_1
        }
        
        for i in 0..<arrImgSelected.count {
            if i+1 == sender.tag {
                arrImgSelected[i].isHidden = false
                arrLblSelectedText[i].textColor = hexStringToUIColor("0FF707")
            } else {
                arrImgSelected[i].isHidden = true
                arrLblSelectedText[i].textColor = UIColor .white
            }
        }
        
    }
    
}



extension CompaignDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collUpper {
            let width = collectionView.frame.width
            let height = (9*width)/16
            
            let frame = collectionView.frame
            return CGSize (width: frame.width, height: frame.height)
        } else if collectionView == collGrinds {
            return CGSize (width: 50, height:70)
        } else if collectionView == collMeals {
            return CGSize (width: 50, height:70)
        } else {
            let width = self.view.frame.width/3-20
            return CGSize (width: width, height:190)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collUpper {
            return (compaignDetails == nil || compaignDetails.gallery!.count == 0)
                ? upperCollectionCount
                : compaignDetails.gallery!.count
        } else if collectionView == collGrinds {
            return arrGrindsValue.count
        } else if collectionView == collMeals {
            return arrMealsValue.count
        } else {
            return arrGetDonner.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collUpper {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CompaignGalleryCollectionViewCell

            if (compaignDetails.gallery!.count == 0) {
                    cell.imgGallery.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.imgGallery.sd_setImage(
                        with:URL(string:compaignDetails.thumbnail!),
                        placeholderImage:UIImage (named:""))
                } else {
                    cell.imgGallery.sd_imageIndicator = SDWebImageActivityIndicator.gray
                    cell.imgGallery.sd_setImage(with: URL(string:compaignDetails.gallery![indexPath.row].image!),
                                                placeholderImage:UIImage (named:""))
                }
           
            return cell
        } else if collectionView == collGrinds {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGrinds", for: indexPath) as! GrindsCollectionViewCell
            
            cell.imgSelectedBG.isHidden = !arrGrindsSelected[indexPath.row]
            cell.imgDownArrow.isHidden = !arrGrindsSelected[indexPath.row]
            
            cell.lblText.text = arrGrindsValue[indexPath.row]
            
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action:#selector(btnSelectGrinds(_:)), for: .touchUpInside)
            
            return cell
        } else if collectionView == collMeals {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMeals", for: indexPath) as! GrindsCollectionViewCell
            
            cell.imgSelectedBG.isHidden = !arrMealsSelected[indexPath.row]
            cell.imgDownArrow.isHidden = !arrMealsSelected[indexPath.row]
            
            cell.lblText.text = arrMealsValue[indexPath.row]
            
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action:#selector(btnSelectMeals), for: .touchUpInside)
            
            if !strGrinds.isEmpty {
                cell.lblText.textColor = (Int64(arrMealsValue[indexPath.row])! <= Int64(strGrinds)!-1)
                    ? UIColor.white.withAlphaComponent(0.5)
                    : UIColor.white
                
                cell.btnSelect.isUserInteractionEnabled = (Int64(arrMealsValue[indexPath.row])! <= Int64(strGrinds)!-1)
                    ? false
                    : true
            } else {
                cell.lblText.textColor = UIColor.white
                cell.btnSelect.isUserInteractionEnabled = true
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAllDonner", for: indexPath) as! AllDonnerCollectionViewCell
            
            cell.imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            cell.imgProfile.sd_setImage(with: URL(string:arrGetDonner[indexPath.row].profile),
                                        placeholderImage:UIImage (named:""))
            cell.lblName.text = arrGetDonner[indexPath.row].fullName
            cell.lblNoOfUnits.text = "\(arrGetDonner[indexPath.row].noOfUnits)"
            
            return cell
        }
        
    }
    
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collUpper {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControll.currentPage = Int(pageNumber)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collUpper {
            let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControll.currentPage = Int(pageNumber)
        }
    }
    
    @IBAction func btnSelectGrinds(_ sender:UIButton) {
        for i in 0..<arrGrindsSelected.count {
            if i == sender.tag {
                arrGrindsSelected[i] = true
            } else {
                arrGrindsSelected[i] = false
            }
        }
        
        strGrinds = arrGrindsValue[sender.tag]
        collGrinds.reloadData()
        
        for i in 0..<arrMealsSelected.count {
            if Int64(strGrinds) == Int64(arrMealsValue[i]) {
                arrMealsSelected[i] = true
            } else {
                arrMealsSelected[i] = false
            }
        }
        
        meals = arrMealsValue[Int(strGrinds)!-1]
        
        collMeals.reloadData()
        collMeals.scrollToItem(at:IndexPath(item:Int(strGrinds)!-1, section:0), at: .right, animated:true)
        
        funcSet2MealsForEveryGrinds()
    }
    
    @IBAction func btnSelectMeals(_ sender:UIButton) {
        for i in 0..<arrMealsSelected.count {
            if i == sender.tag {
                arrMealsSelected[i] = true
            } else {
                arrMealsSelected[i] = false
            }
        }
        
        meals = arrMealsValue[sender.tag]
        collMeals.reloadData()
        
        funcSet2MealsForEveryGrinds ()
    }
    
    func funcSet2MealsForEveryGrinds () {
        if strGrinds.isEmpty && meals.isEmpty {
            lbl2MealsForEveryGridn.text = "Select Grinds & Meals"
            lbl2MealsForEveryGridn.textColor = UIColor.red
        } else if strGrinds.isEmpty || meals.isEmpty {
            lbl2MealsForEveryGridn.textColor = UIColor.red
            if strGrinds.isEmpty {
                lbl2MealsForEveryGridn.text = "Select Grinds also"
            } else {
                lbl2MealsForEveryGridn.text = "Select Meals also"
            }
        } else {
            lbl2MealsForEveryGridn.textColor = UIColor.white
            lbl2MealsForEveryGridn.text = String(format: "%.1f",Float(meals)! / Float(strGrinds)!) + " Meals for every grind!"
        }
    }
    
    @IBAction func btnStartDonnation(_ sender:UIButton) {
        if strGrinds.isEmpty {
            funcAlertController("Select a grind value", UIColor.red)
        } else if meals.isEmpty {
            funcAlertController("Select a meal value", UIColor.red)
        } else {
            (sender.currentTitle! == "START A DONATION")
                ? funcPledge()
                : pushViewController("GrindListViewController", k_MainStoryBoad)
        }
    }
    
    
}



