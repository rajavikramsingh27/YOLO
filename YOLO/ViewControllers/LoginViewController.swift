

//  LoginViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 21/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
//import MBProgressHUD
//import SwiftMessageBar

class LoginViewController: UIViewController {
    
    @IBOutlet weak var lbl_PrivacyPolicy:UILabel!
    let fbLoginManager : LoginManager = LoginManager()
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl_PrivacyPolicy.attributedText = func_attributed_text_With_Range(
            "By creating an account, you agree to YOLO's Privacy Policy of Terms of Use.",
            "Privacy Policy of Terms of Use.",
            UIFont(name: "ProductSans-Regular", size: 14)!,
            UIFont(name: "ProductSans-Bold", size: 14)!)
    }
    
    @IBAction func btnPrivacyPolicy(_ sender: Any) {
        pushViewController("PrivacyPolicyViewController", k_MainStoryBoad)
    }
    
    @IBAction func btnContinueWithInstagram(_ sender: Any) {
        
    }
    
    @IBAction func btnContinueWithFacebook(_ sender: Any) {
        func_facebook()        
    }
    
    func func_API_FBLogin() {
        let loader = showLoader()
        APIFunc.postAPI("login/facebook", ["access_token":k_AccessToken]) { (json) in
            DispatchQueue.main.async {
                self.hideLoader(loader)
                
                if json.dictionaryObject == nil {
                    return
                }
                
                let status = return_status(json.dictionaryObject!)
                
                switch status {
                case .success:
                    k_AccessToken = json.dictionaryObject!["token"] as! String
                    UserDefaults.standard.setValue(k_AccessToken, forKey:k_UserLoginDetails)
                    
                    DispatchQueue.main.async {
                        self.pushViewController("tabbar", k_MainStoryBoad)
                    }
                case .fail:
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.showAlert("\(json.dictionaryObject!["message"]!)", AlertType.error) { (alertAction) in
                            
                        }
                    })
                case .error_from_api:
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                        self.showAlert("Error from API!", AlertType.error) { (alertAction) in
                            
                        }
                    })
                }
            }
        }
    }
    
}



import FBSDKLoginKit
import FBSDKCoreKit



extension LoginViewController {
    func func_facebook() {
        let loader = showLoader()
        self.fbLoginManager.logOut()
        let deletepermission = GraphRequest(graphPath: "me/permissions/", parameters:[:], httpMethod: HTTPMethod(rawValue: "DELETE"))
        deletepermission.start(completionHandler: {(connection,result,error)-> Void in
            print("the delete permission is \(String(describing: result))")
        })
                
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            DispatchQueue.main.async {
                if (error == nil) {
                    let fbloginresult : LoginManagerLoginResult = result!
                    if (result?.isCancelled)!{
                        self.hideLoader(loader)
                        
                        return
                    } else if(fbloginresult.grantedPermissions.contains("email")) {
                        self.hideLoader(loader)
                        k_AccessToken = fbloginresult.token!.tokenString
//                        k_AccessToken = AccessToken.current!.tokenString
                        
//                        self.getFBUserData()
                        self.func_API_FBLogin()
                        self.fbLoginManager.logOut()
                    } else {
                        self.hideLoader(loader)
                    }
                }
            }
        }
        
        
    }

    

    func getFBUserData() {
        let loader = showLoader()
        if((AccessToken.current) != nil) {
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: {
                (connection, result, error) -> Void in
                DispatchQueue.main.async {
                    self.hideLoader(loader)
                    
                    if (error == nil) {
                        let resultJson : NSDictionary = result as! NSDictionary
//                        print(resultJson)

                        let socialID = "\(resultJson["id"] ?? "")"
                        let email = "\(resultJson["email"] ?? "")"

//                        let name = "\(resultJson["name"]!)"
                        let first_name = "\(resultJson["first_name"] ?? "")"
                        let last_name = "\(resultJson["last_name"] ?? "")"

                        let imageDict : NSDictionary = resultJson["picture"] as! NSDictionary
                        let dataOne : NSDictionary = imageDict["data"] as! NSDictionary
                        let imageUrl = "\(dataOne["url"]!)"
                        
//                        print("\(socialID) \n \(email) \n \(first_name) \n \(last_name) \n \(imageUrl)")
                        
                        self.func_API_FBLogin()
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                            self.funcAlertController(error!.localizedDescription, UIColor.red)
                        }
                    }
                }
            })
        }
    }

}
