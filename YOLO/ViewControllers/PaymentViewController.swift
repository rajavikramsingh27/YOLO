
//
//  PaymentViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Of Apps on 25/November/2020.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var constrainsCollectionHeight:NSLayoutConstraint!
    @IBOutlet weak var constrainsCollectionBottom:NSLayoutConstraint!
    @IBOutlet weak var collCardList:UICollectionView!
    
    @IBOutlet weak var viewContinuePayment:UIView!
    @IBOutlet weak var viewSaveCard:UIView!
    
    @IBOutlet weak var btnCreditDebitCard:UIButton!
    @IBOutlet weak var btnApplePay:UIButton!
    @IBOutlet weak var btnGooglePay:UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constrainsCollectionHeight.constant = 0
        constrainsCollectionBottom.constant = 0
        
        viewContinuePayment.isHidden = false
        viewSaveCard.isHidden = true
    }
    
    
    @IBAction func btnCreditDebitCard(_ sender:UIButton) {
        collCardList.isHidden = false
        
        constrainsCollectionHeight.constant = 100
        constrainsCollectionBottom.constant = 17
        
        btnCreditDebitCard.isSelected = true
        btnApplePay.isSelected = false
        btnGooglePay.isSelected = false
    }
    
    
    @IBAction func btnApplePay(_ sender:UIButton) {
        collCardList.isHidden = true
        
        constrainsCollectionHeight.constant = 0
        constrainsCollectionBottom.constant = 0
        
        btnCreditDebitCard.isSelected = false
        btnApplePay.isSelected = true
        btnGooglePay.isSelected = false
    }
    
    @IBAction func btnGooglePay(_ sender:UIButton) {
        collCardList.isHidden = true
        
        constrainsCollectionHeight.constant = 0
        constrainsCollectionBottom.constant = 0
        
        btnCreditDebitCard.isSelected = false
        btnApplePay.isSelected = false
        btnGooglePay.isSelected = true
    }
 
    @IBAction func btnAddCardHide(_ sender:UIButton) {
        viewContinuePayment.isHidden = false
        viewSaveCard.isHidden = true
    }
    
    @IBAction func btnContinue(_ sender:UIButton) {
        pushViewController("PaymentSuccessfullViewController", k_MainStoryBoad)
    }
}



extension PaymentViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize (width:110, height:100)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        constrainsCollectionHeight.constant = 0
        constrainsCollectionBottom.constant = 0
        
        viewContinuePayment.isHidden = true
        viewSaveCard.isHidden = false
    }
    
    
}
