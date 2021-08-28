//
//  EditProfileViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 12/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import SDWebImage


class EditProfileViewController: UIViewController {
    @IBOutlet weak var collYourAge:UICollectionView!
    @IBOutlet weak var collYourHeight:UICollectionView!
    @IBOutlet weak var collYourWeight:UICollectionView!
    
    @IBOutlet weak var viewMale:UIView!
    @IBOutlet weak var viewFemale:UIView!
    @IBOutlet weak var imgMale:UIImageView!
    @IBOutlet weak var imgFemale:UIImageView!
    
    @IBOutlet weak var btnPound:UIButton!
    @IBOutlet weak var btnKG:UIButton!
    
    var arrYourAgeSelected = [Bool]()
    var arrYourAgeValue = [String]()
    
    var arrYourHeightSelected = [Bool]()
    var arrYourHeightValue = [String]()
    
    var arrYourWeightSelected = [Bool]()
    var arrYourWeightValue = [String]()
    
    var isKG = true
    var isMale = true
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        funcMaleFemale()
        
        for i in 0..<100 {
            arrYourAgeValue.append("\(i)")
            arrYourAgeSelected.append(false)
            
            arrYourHeightValue.append("\(i)")
            arrYourHeightSelected.append(false)
            
            arrYourWeightValue.append("\(i)")
            arrYourWeightSelected.append(false)
        }
        
        collYourAge.reloadData()
        collYourHeight.reloadData()
        collYourWeight.reloadData()
    }
    
    func funcMaleFemale() {
        imgMale.isHidden = !isMale
        imgFemale.isHidden = isMale
        
        viewMale.layer.borderWidth = isMale ? 0 : 1
        viewFemale.layer.borderWidth = isMale ? 1 : 0
    }
    
    @IBAction func btn_KG_Pound(_ sender:UIButton) {
        isKG = (sender.tag == 1) ? true : false
        
        arrYourWeightValue.removeAll()
        arrYourWeightSelected.removeAll()
        
        if isKG {
            btnKG.backgroundColor = UIColor.white
            btnPound.backgroundColor = UIColor.clear
            btnKG.setTitleColor(UIColor.black, for: .normal)
            btnPound.setTitleColor(UIColor.white, for: .normal)
                        
            for i in 0..<100 {
                arrYourWeightValue.append("\(i)")
                arrYourWeightSelected.append(false)
            }
        } else {
            btnKG.backgroundColor = UIColor.clear
            btnPound.backgroundColor = UIColor.white
            
            btnPound.setTitleColor(UIColor.black, for: .normal)
            btnKG.setTitleColor(UIColor.white, for: .normal)
            
          for i in 0..<20 {
               arrYourWeightValue.append("\(i)")
               arrYourWeightSelected.append(false)
           }
        }
        
        collYourWeight.reloadData()
    }
    
    @IBAction func btnMaleFemale(_ sender:UIButton) {
        isMale = (sender.tag == 1) ? true : false
        
        funcMaleFemale()
    }
    
}


extension EditProfileViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize (width: 50, height:70)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collYourAge {
            return arrYourAgeValue.count
        } else if collectionView == collYourHeight {
            return arrYourHeightValue.count
        } else {
            return arrYourWeightValue.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collYourAge {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellYourAge", for: indexPath) as! GrindsCollectionViewCell
            
            cell.imgSelectedBG.isHidden = !arrYourAgeSelected[indexPath.row]
            cell.imgDownArrow.isHidden = !arrYourAgeSelected[indexPath.row]
            
            cell.lblText.text = arrYourAgeValue[indexPath.row]

            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action:#selector(btnYourAge), for: .touchUpInside)
            
            return cell
        } else if collectionView == collYourHeight {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellYourHeight", for: indexPath) as! GrindsCollectionViewCell
            
            cell.imgSelectedBG.isHidden = !arrYourHeightSelected[indexPath.row]
            cell.imgDownArrow.isHidden = !arrYourHeightSelected[indexPath.row]

            cell.lblText.text = arrYourHeightValue[indexPath.row]

            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action:#selector(btnYourHeight(_:)), for: .touchUpInside)
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellYourWeight", for: indexPath) as! GrindsCollectionViewCell
            
            cell.imgSelectedBG.isHidden = !arrYourWeightSelected[indexPath.row]
            cell.imgDownArrow.isHidden = !arrYourWeightSelected[indexPath.row]

            cell.lblText.text = arrYourWeightValue[indexPath.row]
            
            cell.btnSelect.tag = indexPath.row
            cell.btnSelect.addTarget(self, action:#selector(btnYourWeight), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    @IBAction func btnYourAge(_ sender:UIButton) {
        for i in 0..<arrYourAgeSelected.count {
            if i == sender.tag {
                arrYourAgeSelected[i] = true
            } else {
                arrYourAgeSelected[i] = false
            }
        }
        
        collYourAge.reloadData()
       
//        collMeals.scrollToItem(at:IndexPath(item:Int(strGrinds)!-1, section:0), at: .right, animated:true)
    }
    
    @IBAction func btnYourHeight(_ sender:UIButton) {
        for i in 0..<arrYourHeightSelected.count {
            if i == sender.tag {
                arrYourHeightSelected[i] = true
            } else {
                arrYourHeightSelected[i] = false
            }
        }
        
        collYourHeight.reloadData()
    }
    
    @IBAction func btnYourWeight(_ sender:UIButton) {
        for i in 0..<arrYourWeightSelected.count {
            if i == sender.tag {
                arrYourWeightSelected[i] = true
            } else {
                arrYourWeightSelected[i] = false
            }
        }
        
        collYourWeight.reloadData()
    }
    
}


