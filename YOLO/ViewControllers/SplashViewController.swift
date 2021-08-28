

//  SplashViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 21/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import AVFoundation


class SplashViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let dictMealsGrinds = UserDefaults.standard.object(forKey:k_MealsGrinds) as? [String:String] {
            strGrinds = "\(dictMealsGrinds["grinds"]!)"
            meals = "\(dictMealsGrinds["meals"]!)"
            selectedComapaignID = "\(dictMealsGrinds["compaignID"]!)"
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                if let accToken = UserDefaults.standard.object(forKey:k_UserLoginDetails) as? String {
                    k_AccessToken = accToken
                    
                    let tabbar = self.storyboard!.instantiateViewController(withIdentifier:"tabbar")
                    tabbar.modalPresentationStyle = .fullScreen
                    self.present(tabbar, animated: true, completion:nil)
                    
                    let compaignDetailsVC = self.storyboard!.instantiateViewController(withIdentifier:"CompaignDetailsViewController") as! CompaignDetailsViewController
                    let navigationController = UINavigationController(rootViewController:compaignDetailsVC)
                    navigationController.setNavigationBarHidden(true, animated: false)
                    self.present(navigationController, animated: true, completion: nil)
                } else {
                    self.pushViewController("WalkthroughViewController", k_MainStoryBoad)
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                if let accToken = UserDefaults.standard.object(forKey:k_UserLoginDetails) as? String {
                    k_AccessToken = accToken
                    
                    let tabbar = self.storyboard!.instantiateViewController(withIdentifier:"tabbar")
                    tabbar.modalPresentationStyle = .fullScreen
                    self.present(tabbar, animated: true, completion:nil)
                } else {
                    self.pushViewController("WalkthroughViewController", k_MainStoryBoad)
                }
                
            }
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
