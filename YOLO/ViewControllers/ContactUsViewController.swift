//
//  ContactUsViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 15/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var txtWriteMessage:UITextView!
    
    var strPlaceHolderWriteMessage = "Write your message..."
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
}

extension ContactUsViewController:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == strPlaceHolderWriteMessage {
            textView.text = ""
            textView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = strPlaceHolderWriteMessage
            textView.textColor = UIColor.white.withAlphaComponent(0.8)
        }
        
    }
    
}
