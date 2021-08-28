

//  ClickedViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 03/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import SDWebImage


var imgSelected_Clicked = UIImage()
var grindID = ""
var meals = "20"
var strNGO_Logo = ""


class ClickedViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var imgSelected:UIImageView!
    @IBOutlet weak var imgSticker:UIImageView!
    @IBOutlet weak var lblMeals:UILabel!
    @IBOutlet weak var viewStickerImage:UIView!
    
    @IBOutlet weak var btnShareOnFeed:UIButton!
    
    var documentController = UIDocumentInteractionController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblMeals.text = meals
        imgSelected.image = imgSelected_Clicked
        
        imgSticker.sd_imageIndicator = SDWebImageActivityIndicator.white
        imgSticker.sd_setImage(with: URL(string:strNGO_Logo), placeholderImage:UIImage (named:""))
    }
    
    @IBAction func btnShareToStory(_ sender:UIButton) {
        func_API_LogWorkout()
        shareToInstagram(deepLinkString: "")
    }
    
    @IBAction func btnShareOnFeed(_ sender:UIButton) {
        func_API_LogWorkout()
        shareToInstagramFeed(imgSelected.image!)
    }
    
    @IBAction func btnProfile(_ sender:UIButton) {
        self.navigationController!.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selectedIndex"), object: nil)
    }
    
    func shareToInstagramFeed(_ image: UIImage) {
        // build the custom URL scheme
        guard let instagramUrl = URL(string: "instagram://app") else {
            return
        }
        
        // check that Instagram can be opened
        if UIApplication.shared.canOpenURL(instagramUrl) {
            // build the image data from the UIImage
            guard let imageData = image.jpegData(compressionQuality: 100) else {
                return
            }
            
            // build the file URL
            let path = (NSTemporaryDirectory() as NSString).appendingPathComponent("instagram.ig")
            let fileUrl = URL(fileURLWithPath: path)
            
            do {
                try imageData.write(to: fileUrl, options: .atomic)
            } catch {
                // could not write image data
                return
            }
            
            documentController.delegate = self
            documentController.url = fileUrl
//            documentController.uti = "com.instagram.photo"
            documentController.uti = "com.instagram.exclusivegram"
            documentController.presentOpenInMenu(from:btnShareOnFeed.frame, in:btnShareOnFeed, animated:true)
        } else {
//            goToAppStore()
        }
    }
    
    func shareToInstagram(deepLinkString : String) {
        let url = URL(string: "instagram-stories://share")!
        if UIApplication.shared.canOpenURL(url) {
            
            let backgroundData = imgSelected.image!.jpegData(compressionQuality: 1.0)!
            let stickerData = getScreenshot(viewStickerImage)
//                UIImage(named: "logo")!.pngData()
            
            let pasteBoardItems = [["com.instagram.sharedSticker.backgroundImage": backgroundData,
                                    "com.instagram.sharedSticker.stickerImage": stickerData,
//                          "com.instagram.sharedSticker.backgroundTopColor":"#FF0000",
//                          "com.instagram.sharedSticker.backgroundBottomColor": "#00FF00"
            ]]
            
            if #available(iOS 10.0, *) {
                UIPasteboard.general.setItems(pasteBoardItems, options: [.expirationDate: Date().addingTimeInterval(60 * 5)])
            } else {
                UIPasteboard.general.items = pasteBoardItems
            }
            UIApplication.shared.openURL(url)
        } else {
            let urlStr = "https://itunes.apple.com/in/app/instagram/id389801252?mt=8"
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
                
            } else {
                UIApplication.shared.openURL(URL(string: urlStr)!)
            }
        }
        
    }
    
    func func_API_LogWorkout() {
        let dictMealsGrinds = ["meals":meals,"grinds":strGrinds,"compaignID":selectedComapaignID]
        UserDefaults.standard.set(dictMealsGrinds, forKey:k_MealsGrinds)
        
        let param = ["grind_id":grindID,
                     "media_type":"image",
                     "contribution_id":strContributionID]
        
        let loader = showLoader()
        let stickerData = getScreenshot(viewStickerImage)
                    
        APIFunc.postAPI_Image("log/workout", param, imgSelected.image!, stickerData) { (error,message) in
            DispatchQueue.main.async {
                self.hideLoader(loader)
                if error == "0" {
                    self.showAlert(message, AlertType.success) { (action) in
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    self.showAlert(message, AlertType.error) { (action) in
                        
                    }
                }
                
            }
        }
    }
    
    func getScreenshot(_ viewToSnapShot:UIView) -> UIImage {
        UIGraphicsBeginImageContext(viewToSnapShot.frame.size)
//        UIGraphicsBeginImageContext(CGSize(width:viewToSnapShot.frame.width, height:116))
        viewToSnapShot.layer.render(in: UIGraphicsGetCurrentContext()!)
        viewToSnapShot.layer.backgroundColor = UIColor.clear.cgColor
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        return image!
    }
    
    func makeTransparent(_ image: UIImage) -> UIImage? {
        guard let rawImage = image.cgImage else { return nil}
        let colorMasking: [CGFloat] = [255, 255, 255, 255, 255, 255]
        UIGraphicsBeginImageContext(image.size)
        
        if let maskedImage = rawImage.copy(maskingColorComponents: colorMasking),
            let context = UIGraphicsGetCurrentContext() {
            context.translateBy(x: 0.0, y: image.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(maskedImage, in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            let finalImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return finalImage
        }
        
        return nil
    }
    
}



