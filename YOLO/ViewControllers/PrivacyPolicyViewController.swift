//
//  PrivacyPolicyViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 22/11/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit
import SDWebImage



class PrivacyPolicyViewController: UIViewController {
    @IBOutlet weak var txtPrivacyPolicy:UITextView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        funcPrivacyAndPolicy()
    }
    
    
    
    func funcPrivacyAndPolicy() {
            let loader = showLoader()
            APIFunc.getAPI("static/content/privacy-and-policy", [:]) { (json) in
                DispatchQueue.main.async {
                    self.hideLoader(loader)
                    
                    if json.dictionaryObject == nil {
                        return
                    }
                    
                    let status = return_status(json.dictionaryObject!)
                    
                    switch status {
                    case .success:
                        let dictData = json.dictionaryObject!["data"] as? [String:Any]
                        
                        DispatchQueue.main.async {
                            self.txtPrivacyPolicy.text = "\(dictData!["content"]!)".html2String
                        }
                    case .fail:
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                            self.showAlert("\(json.dictionaryObject!["message"]!)", AlertType.error) { (okAction) in
                                
                            }
                        })
                    case .error_from_api:
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
                            self.showAlert("Error from API", AlertType.error) { (okAction) in
                                
                            }
                        })
                    }
                }
            }
        }

}


extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}


extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
