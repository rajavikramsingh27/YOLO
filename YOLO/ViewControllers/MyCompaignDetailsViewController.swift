

//  CompaignAddViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 23/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit


class MyCompaignDetailsViewController: UIViewController {
    @IBOutlet weak var pageControll:UIPageControl!
    @IBOutlet weak var collUpper:UICollectionView!
    @IBOutlet weak var collGrinds:UICollectionView!
    @IBOutlet weak var collMeals:UICollectionView!
    @IBOutlet weak var collAllDonner:UICollectionView!
    @IBOutlet weak var collDonnationList:UICollectionView!
    @IBOutlet weak var viewDonnationList:UIView!
    @IBOutlet weak var viewMyProgress:UIView!
    
    
    @IBOutlet var arrImgMyPledgeAllDonner_SelectedImage:[UIImageView]!
    @IBOutlet var arrLblMyPledgeAllDonner_SelectedText:[UILabel]!
    
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var btnReadMore:UIButton!
    
    var intPledgeSelected = 1
    var arrGrindsSelected = [Bool]()
    var arrGrindsValue = ["07","08","09","10","11","12","13",]
    
    var arrMealsSelected = [Bool]()
    var arrMealsValue = ["17","18","19","20","21","22","23",]
    
    var arrDonationTypeListIcons = ["workout","cycle","running","basketBall","soccer","tennis","golf","others"]
    var arrDonationTypeListTitle = ["Workout","Cycling","Running","BasketBall","Soccer","Tennis","Golf","Others"]
    
    var arrDonnationTypeSelect = [Bool]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblDescription.numberOfLines = 4
        
        for i in 0..<arrGrindsValue.count {
            arrGrindsSelected.append(i == 0 ? true : false)
        }
        
        collGrinds.reloadData()
        
        for i in 0..<arrMealsValue.count {
            arrMealsSelected.append(i == 0 ? true : false)
        }
        
        collMeals.reloadData()
        
        for i in 0..<arrDonationTypeListIcons.count {
            arrDonnationTypeSelect.append(i == 0 ? true : false)
        }
        
        collDonnationList.reloadData()
        
        funcPledgeAllDonnerSelected()
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
        intPledgeSelected = sender.tag
        funcPledgeAllDonnerSelected()
    }
    
    
    
    func funcPledgeAllDonnerSelected() {
        for i in 0..<arrImgMyPledgeAllDonner_SelectedImage.count {
            if intPledgeSelected == 1 {
                collAllDonner.isHidden = true
                viewMyProgress.isHidden = true
            } else if intPledgeSelected == 2 {
                collAllDonner.isHidden = true
                viewMyProgress.isHidden = false
            } else if intPledgeSelected == 3 {
                collAllDonner.isHidden = false
                viewMyProgress.isHidden = true
            }
            
            arrImgMyPledgeAllDonner_SelectedImage[i].isHidden = (intPledgeSelected == i+1) ? false : true
            arrLblMyPledgeAllDonner_SelectedText[i].textColor =
                (intPledgeSelected == i+1)
                ? hexStringToUIColor("0FF707")
                : UIColor.white
        }
        
    }
    
    
}



extension MyCompaignDetailsViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collUpper {
            let frame = collectionView.frame
            return CGSize (width: frame.width, height: frame.height)
        } else if collectionView == collGrinds {
            return CGSize (width: 50, height:70)
        } else if collectionView == collMeals {
            return CGSize (width: 50, height:70)
        } else if collectionView == collAllDonner {
            let width = self.view.frame.width/3-20
            return CGSize (width: width, height:220)
        } else {
            let width = self.view.frame.width/3-30
            return CGSize (width: width, height:width)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collUpper {
            return 4
        } else if collectionView == collGrinds {
            return arrGrindsValue.count
        } else if collectionView == collMeals {
            return arrMealsValue.count
        } else if collectionView == collAllDonner {
            return 21
        } else {
            return arrDonationTypeListIcons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collUpper {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            
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
            
            return cell
        } else if collectionView == collAllDonner {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellAllDonner", for: indexPath)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDonnationList", for: indexPath) as! DonnationTypeCollectionViewCell
            let width = self.view.frame.width/3-30
            
            cell.imgCircle.layer.borderColor = UIColor.white.cgColor
            cell.imgCircle.layer.borderWidth = arrDonnationTypeSelect[indexPath.row] ? 0 : 2
            cell.imgCircle.layer.cornerRadius = width/2
            cell.imgCircle.clipsToBounds = true
            
            cell.imgCircle.image = UIImage (named:arrDonationTypeListIcons[indexPath.row])
            cell.imgBG.isHidden = !arrDonnationTypeSelect[indexPath.row]
            
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action:#selector(btnDonnationTypeSelect), for: .touchUpInside)
            
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
        collGrinds.reloadData()
    }
    
    @IBAction func btnSelectMeals(_ sender:UIButton) {
        for i in 0..<arrMealsSelected.count {
            if i == sender.tag {
                arrMealsSelected[i] = true
            } else {
                arrMealsSelected[i] = false
            }
        }
        collMeals.reloadData()
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
        pushViewController("PaymentViewController", k_MainStoryBoad)

    }
    
    @IBAction func btnStartDonnation(_ sender:UIButton) {
        viewDonnationList.isHidden = !viewDonnationList.isHidden
    }
    
    
}



