

import Foundation
import UIKit

import StoreKit


extension UIViewController {
    @IBAction func btnBack(_ sender:Any) {
        if navigationController?.viewControllers.count == 1 {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated:true)
        }
    }

    
    func funcOpenAppSettings(_ message:String)  {
        let alert = UIAlertController(title:"YOLO APP", message:message, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title:"Go to settings", style:.default, handler: { (action) in
            let settingsUrl = URL(string: UIApplication.openSettingsURLString)
            UIApplication.shared.open(settingsUrl!,completionHandler: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(_ message:String,_ alertType:AlertType, completion: @escaping ( _ json:String) -> ())  {
        let strTitle = (alertType == AlertType.success) ? "Success!" : "Error!"
        let alert = UIAlertController (title:strTitle, message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style: .cancel, handler: { (action) in
            completion("Clicked")
        }))
        
       /* let attributedString = NSAttributedString(string:strTitle, attributes: [
            NSAttributedString.Key.font : UIFont (name:"ProductSans-Bold", size:18)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ])
        alert.setValue(attributedString, forKey: "attributedTitle")
        
        let attributedmessage = NSAttributedString(string:message, attributes: [
            NSAttributedString.Key.font : UIFont (name:"ProductSans-Regular", size:16)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ])
        alert.setValue(attributedmessage, forKey: "attributedMessage")
        
         alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = (alertType == AlertType.success)
             ? k_ThemeColor_Green : UIColor.red
         alert.view.tintColor = UIColor.white
         */
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLoader() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        return activityIndicator
    }
    
    func hideLoader(_ activityIndicator:UIActivityIndicatorView) {
        activityIndicator.stopAnimating()
    }
    
    func funRemoveFromSuperview() {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 0, options: [], animations: {
            self.view.transform = CGAffineTransform(scaleX:0.02, y: 0.02)
        }) { (success) in
            self.view.removeFromSuperview()
        }
    }
    
    func func_removeFromSuperview() {
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping:0.5, initialSpringVelocity: 0, options: [], animations: {
                self.view.transform = CGAffineTransform(scaleX:0.02, y: 0.02)
            }) { (success) in
                self.view.removeFromSuperview()
            }
        }
        
        func func_attributed_text(_ color_1:UIColor,_ color_2:UIColor,_ font_1:UIFont,_ font_2:UIFont,_ text_1:String,_ text_2:String) -> NSAttributedString {
            let attrs1 = [NSAttributedString.Key.font:font_1, NSAttributedString.Key.foregroundColor:color_1]
            let attrs2 = [NSAttributedString.Key.font:font_2, NSAttributedString.Key.foregroundColor:color_2]
            
            let attributedString1 = NSMutableAttributedString(string:text_1, attributes:attrs1)
            let attributedString2 = NSMutableAttributedString(string:text_2, attributes:attrs2)
            
            attributedString1.append(attributedString2)
            
            return attributedString1
        }
        
    //    func func_attributed_string(font_name:String,text:String,color:String) -> NSMutableAttributedString{
    //        let attrs11 = [NSAttributedString.Key.font:UIFont (name:font_name, size:16.0), NSAttributedString.Key.foregroundColor:hexStringToUIColor(color)]
    //        let attributedString11 = NSMutableAttributedString(string:text, attributes:attrs11 as [NSAttributedString.Key : Any])
    //        return attributedString11
    //    }
        
        func func_attributed_text_With_Range(_ fullString:String, _ boldPartOfString: String, _ font: UIFont!, _ boldFont: UIFont!) -> NSAttributedString {
            let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
            let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
            let boldString = NSMutableAttributedString(string: fullString as String, attributes:nonBoldFontAttribute)
            
            let strFullString = fullString as NSString
            boldString.addAttributes(boldFontAttribute, range:strFullString.range(of: boldPartOfString))
            
            return boldString
        }
        
        func height_according_to_text(_ text:String, _ font:UIFont) -> CGFloat {
            let label = UILabel(frame:CGRect (x: 0, y: 0, width:self.view.bounds.width-40, height:.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            
            label.sizeToFit()
            return label.frame.height
        }
        
        func heightAccordingText(_ text:String, _ font:UIFont,_ width:CGFloat) -> CGFloat {
            let label = UILabel(frame:CGRect (x: 0, y: 0, width:width, height:.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = font
            label.text = text
            
            label.sizeToFit()
            return label.frame.height
        }
        
    func funcAlertController(_ message:String,_ color:UIColor) {
        let attributedString = NSAttributedString(string:message, attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize:18),
            NSAttributedString.Key.foregroundColor : color
        ])
        
        let alert_C = UIAlertController (title: message, message: "", preferredStyle: .alert)
        alert_C.setValue(attributedString, forKey: "attributedTitle")
        present(alert_C, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+1.2) {
            alert_C.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func funcSelectedIndex() {
        self.tabBarController?.selectedIndex = 2
    }
    
    func pushViewController(_ identifier:String, _ storyBoard_Name:String)  {
        let storyBoard = UIStoryboard (name:storyBoard_Name, bundle:nil)
        let viewContrller = storyBoard.instantiateViewController(withIdentifier:identifier)
        self.navigationController?.pushViewController(viewContrller, animated: true)
    }
    
    func presentViewController(_ identifier:String, _ storyBoard_Name:String)  {
        let storyBoard = UIStoryboard (name:storyBoard_Name, bundle:nil)
        let viewContrller = storyBoard.instantiateViewController(withIdentifier:identifier)
        self.present(viewContrller, animated: true, completion: nil)
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()

        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "appId") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)

            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func shareTextButton(_ sender:String) {

        let activityViewController = UIActivityViewController(activityItems: [sender], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // exclude some activity types from the list (optional)
//        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
}



// MARK:- string
extension String {
    func sizeText(_ font:UIFont) -> CGSize {
        let myText = self as NSString
        let size = myText.size(withAttributes:[NSAttributedString.Key.font:font])
        return size
    }
    
    func sizeAccordingText(_ width: CGFloat,_ font: UIFont) -> CGSize {
        let maxSize = CGSize(width: width, height:.greatestFiniteMagnitude)
        return self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil).size
    }
    
    func height_According_Text(_ width: CGFloat,_ font: UIFont) -> CGFloat {
        let maxSize = CGSize(width: width, height:.greatestFiniteMagnitude)
        let actualSize = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return actualSize.height
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with:self)
    }
    
    func bold(_ text:String) -> NSMutableAttributedString {
       let attrs1 = [NSAttributedString.Key.font:UIFont (name: "Roboto-Regular", size: 16)]
       let attrs2 = [NSAttributedString.Key.font:UIFont (name: "Roboto-Light", size: 16)]
       let attributedString1 = NSMutableAttributedString(string:self, attributes:attrs1 as [NSAttributedString.Key : Any])
       let attributedString2 = NSMutableAttributedString(string:text, attributes:attrs2 as [NSAttributedString.Key : Any])
       attributedString1.append(attributedString2)
       
       return attributedString1
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    func dateDifference() -> (month: Int, day: Int, hour: Int, minute: Int, second: Int) {
       let dateFormatter = DateFormatter()
       dateFormatter.dateFormat = "yyyy/MM/dd hh:mm a"
       
       let previous = dateFormatter.date(from: self)
       
       let day = Calendar.current.dateComponents([.day], from:Date(), to:previous!).day
       let month = Calendar.current.dateComponents([.month], from:Date(), to:previous!).month
       let hour = Calendar.current.dateComponents([.hour], from:Date(), to:previous!).hour
       let minute = Calendar.current.dateComponents([.minute], from:Date(), to:previous!).minute
       let second = Calendar.current.dateComponents([.second], from:Date(), to:previous!).second
       
       return (month:month!,day:day!,hour:hour!, minute:minute!,second:second!)
    }
    
    var dictionary:[String:Any] {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as? [String:Any]
                return json ?? [:]
            } catch {
                print("Something went wrong")
                return [:]
            }
        } else {
            return [:]
        }
    }
    
    var array:[[String:Any]] {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options:.mutableContainers) as? [[String:Any]]
                return json ?? [[:]]
            } catch {
                print("Something went wrong")
                return [[:]]
            }
        } else {
            return [[:]]
        }
    }
    
    var UTCToLocal:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //"H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from:self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    var timeFormat:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date_created = dateFormatter.date(from:self)
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date_created ?? Date())
    }
    
    var timeFormatMMDDYYYY:String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date_created = dateFormatter.date(from:self)
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter.string(from: date_created ?? Date())
    }
    
    var saveImageIn:Bool {
        if let url = URL(string:self),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            return true
        } else {
            return false
        }
    }
    
    var appDefaultDate:String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:self)!
        
        dateFormatter.dateFormat = "MMM dd"
        dateFormatter.string(from: date)
        return dateFormatter.string(from: date)
    }
    
    func getElapsedInterval(_ dF:String) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = dF //"dd/MM/yyyy hh:mm"
        let date = dateFormat.date(from:self)
        
        let interval = Calendar.current.dateComponents([.year, .month, .day], from:date ?? Date(), to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else {
            return "a moment ago"
        }
                        
    }
    
    func dateFromString(_ dateFormat:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from:self) ?? Date()
        
        return date
    }
}

extension Dictionary {
    var json: String {
                
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options:.fragmentsAllowed)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
}

extension Array {
    var json: String {
        let invalidJson = "Not a valid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options:.fragmentsAllowed)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
    
}





func extractUserInfo(_ userInfo: [AnyHashable : Any]) -> (title: String, body: String) {
    var info = (title: "", body: "")
    guard let aps = userInfo["aps"] as? [String: Any] else { return info }
    guard let alert = aps["alert"] as? [String: Any] else { return info }
    let title = alert["title"] as? String ?? ""
    let body = alert["body"] as? String ?? ""
    info = (title: title, body: body)
    return info
}


func hexStringToUIColor (_ hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


// MARK:- AVKit
import AVKit
extension URL {
    var createVideoThumbnail:UIImage? {
        let asset = AVAsset(url:self)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        assetImgGenerate.maximumSize = UIScreen.main.bounds.size
        
        let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}


extension Date {
    func dateToString(_ dateFormat:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.string(from:self)
        
        return date
    }
}



extension UIColor {
    func shadow(_ view:UIView) {
//        view.layer.cornerRadius = 24
        
        view.layer.shadowColor = self.cgColor
        view.layer.shadowOffset = CGSize(width:3, height:4)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 6
        view.layer.shadowPath = UIBezierPath(roundedRect:view.bounds, cornerRadius:24).cgPath
        view.layer.masksToBounds = false
    }
    
}


//import CoreLocation
//import GoogleMaps
//extension CLLocationCoordinate2D {
//    func reverseGeocodeCoordinate(completion:@escaping (String)->()) {
//         let geoCoder = GMSGeocoder()
//        geoCoder.reverseGeocodeCoordinate(self) { (placemarks, error) in
//            if error != nil {
//                completion(error!.localizedDescription)
//            } else {
//                let dictAddress = placemarks?.firstResult()
//                completion(dictAddress?.lines?.first ?? "Address not found")
//            }
//        }
//    }
//
//}



enum AlertType {
    case error
    case success
}

enum status_type {
    case error_from_api
    case success
    case fail
}

func return_status(_ resp:[String:Any]) -> status_type {
    if let error = resp["error"] as? Bool {
        if error {
            return status_type.error_from_api
        } else {
            if error {
                return status_type.fail
            } else {
                return status_type.success
            }
        }
    } else {
        return status_type.error_from_api
    }
    
}



