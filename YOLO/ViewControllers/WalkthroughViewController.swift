//
//  WalkthroughViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 21/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit
//import AnimatedCollectionViewLayout

class WalkthroughViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let arr_Walkthrough_Images = ["walkthrough_1","walkthrough_2","walkthrough_3"]
    
    let arr_Walkthrough_Title_First = ["Lorem ipsum dolor sit amet consetetur sadipscing"
        ,"Lorem ipsum dolor sit amet consetetur sadipscing"
        ,"Lorem ipsum dolor sit amet consetetur sadipscing"]
    
    let arr_Walkthrough_Title_Second = ["Lorem ipsum dolor sit amet consetetur sadipscing"
        ,"Lorem ipsum dolor sit amet consetetur sadipscing"
        ,"Lorem ipsum dolor sit amet consetetur sadipscing"]
    
    var index = 0
    
    @IBOutlet weak var pageControll:UIPageControl!
    @IBOutlet weak var collWalkthrough:UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        pageControll.numberOfPages = arr_Walkthrough_Images.count
        
        //        let layout = AnimatedCollectionViewLayout()
        //        layout.animator = ParallaxAttributesAnimator()
        //        layout.scrollDirection = .horizontal
        //        collWalkthrough.collectionViewLayout = layout
    }
    

    @IBAction func btnNext(_ sender: Any) {
        pushViewController("LoginViewController", k_MainStoryBoad)
//        if index == 2 {
//            print(index)
//            pushViewController("LoginViewController", k_MainStoryBoad)
//        }
//
//        let collectionBounds = self.collWalkthrough.bounds
//        let contentOffset = CGFloat(floor(self.collWalkthrough.contentOffset.x + collectionBounds.size.width))
//        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect =  CGRect (x: contentOffset, y: self.collWalkthrough.contentOffset.y, width: self.collWalkthrough.frame.width, height: self.collWalkthrough.frame.height)
        self.collWalkthrough.scrollRectToVisible(frame, animated: true)
    }
    
}



extension WalkthroughViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frame = collectionView.frame
        
        return CGSize (width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr_Walkthrough_Images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WalkthroughCollectionViewCell
        
        cell.img_Walkthrough_Images.image = UIImage (named:arr_Walkthrough_Images[indexPath.row])
        cell.lbl_Walkthrough_Title_First.text = arr_Walkthrough_Title_First[indexPath.row]
        cell.lbl_Walkthrough_Title_Second.text = arr_Walkthrough_Title_Second[indexPath.row]
        
        return cell
    }

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControll.currentPage = Int(pageNumber)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControll.currentPage = Int(pageNumber)
        
        index = Int(pageNumber)
        print(index)
    }
    
}
