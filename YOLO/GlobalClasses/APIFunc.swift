

//  APIFunc.swift
//  YOLO


//  Created by Boons&Blessings Apps on 06/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import Foundation
import Alamofire
import SwiftMessageBar
import SwiftyJSON


class APIFunc {
    class func postAPI_Header(_ url: String , _ parameters: [String:Any] , completion:@escaping (_ json:JSON)->()) {
        if Reachability.isConnectedToNetwork() {
            let apiURL = kBaseURL+url
            
            var urlRequest = URLRequest(url:URL (string:apiURL)!)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
            urlRequest.addValue("Bearer \(k_AccessToken)", forHTTPHeaderField: "Authorization")
            
            let headers:HTTPHeaders = ["Authorization":"Bearer \(k_AccessToken)"]
            
            AF.request(apiURL, method: .post, parameters:parameters,encoding: JSONEncoding.default, headers:headers).responseJSON { (response) in
                switch response.result {
                case .success:
                    let json = JSON(response.data!)
                    let dictCleanJSON = cleanJsonToObject(json.dictionaryObject as AnyObject) as! [String:Any]
                    completion(JSON(dictCleanJSON))
                    break
                case .failure(let error):
                    completion(["status":"failed","message":"\(error.localizedDescription)"])
                    break
                }
            }
        } else {
            completion(["status":"failed","message":"Connect Your Device with Internet"])
        }
        
    }
    
    class func postAPI(_ url: String , _ parameters: [String:Any] , completion:@escaping (_ json:JSON)->()) {
        if Reachability.isConnectedToNetwork() {
            let apiURL = kBaseURL+url

//            var urlRequest = URLRequest(url:URL (string:apiURL)!)
//            urlRequest.httpMethod = HTTPMethod.get.rawValue
//            urlRequest.httpBody = parameters.percentEncoded()
            
            AF.request(apiURL, method: .post, parameters: parameters).validate().responseString { (response) in
                switch response.result {
                case .success:
                    let json = JSON(response.data!)
                    let dictCleanJSON = cleanJsonToObject(json.dictionaryObject as AnyObject) as! [String:Any]
                    completion(JSON(dictCleanJSON))
                    break
                case .failure(let error):
                    completion(["status":"failed","message":"\(error.localizedDescription)"])
                    break
                }
            }
        } else {
            completion(["status":"failed","message":"Connect Your Device with Internet"])
        }

    }
    
    class func getAPI(_ url: String ,_ parameters: [String:String] ,completion: @escaping( _ json:JSON) -> ()) {
        if Reachability.isConnectedToNetwork() {
            let apiURL = kBaseURL+url
            
            var urlRequest = URLRequest(url:URL (string:apiURL)!)
            urlRequest.httpMethod = HTTPMethod.get.rawValue
            
            urlRequest.addValue("Bearer \(k_AccessToken)", forHTTPHeaderField: "Authorization")
            
            AF.request(urlRequest).validate().responseString { (response) in
                switch response.result {
                case .success:
                    let json = JSON(response.data!)
                    let dictCleanJSON = cleanJsonToObject(json.dictionaryObject as AnyObject) as! [String:Any]
                    completion(JSON(dictCleanJSON))
                    
                    break
                case .failure(let error):
                    completion(["status":"failed","message":"\(error.localizedDescription)"])
                    break
                }
            }
        } else {
            completion(["status":"failed","message":"Connect Your Device with Internet"])
        }
        
    }
    
    class func postAPI_Image(_ url: String,
                             _ parameters: [String : String],
                             _ imgMedia:UIImage ,
                             _ imgSticker:UIImage,
                             completion:@escaping (_ error:String, _ message:String)->()) {
        if Reachability.isConnectedToNetwork() {
            let urlFull = URL (string: kBaseURL+url) /* your API url */
            
            let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data",
                "Authorization":"Bearer \(k_AccessToken)"
            ]
            
            let dataMedia = imgMedia.jpegData(compressionQuality: 0.3)!
            let dataSticker = imgSticker.jpegData(compressionQuality: 0.3)!
            
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using:.utf8)!, withName: key as String)
                }
                
                multipartFormData.append(dataMedia, withName:"media", fileName: "image.jpeg", mimeType: "image/jpeg")
                multipartFormData.append(dataSticker, withName:"sticker", fileName: "image.jpeg", mimeType: "image/jpeg")
                
            }, to: urlFull!, usingThreshold: UInt64.init(), method: .post, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON (data: response.data!)
                        let dictJSON = cleanJsonToObject(json.dictionaryObject as AnyObject) as! [String:Any]
                        completion("\(dictJSON["error"]!)","\(dictJSON["message"]!)")
                    } catch {
                        completion("1","Error From API")
                    }
                    break
                case .failure(let error):
                    completion("1","\(error.localizedDescription)")
                    break
                }
            }
        } else {
            completion("1","Connect Your Device with Internet")
        }
    }
    
    class func postAPI_Video(_ url: String,_ video_Data: Data?,_ parameters: [String : String],_ video_param:String, completion:@escaping ( _ message:String)->()) {
        if Reachability.isConnectedToNetwork() {
            let url = URL (string: kBaseURL+url) /* your API url */
            
            let headers: HTTPHeaders = [
                "Content-type": "multipart/form-data",
                "Authorization":"Bearer \(k_AccessToken)"
            ]
            
            AF.upload(multipartFormData: { (multipartFormData : MultipartFormData) in
                let timestamp = NSDate().timeIntervalSince1970
                
                multipartFormData.append(video_Data!, withName:video_param, fileName: "\(timestamp).mp4" , mimeType: "video/mp4")
                for (key, value) in parameters {
                    multipartFormData.append(value.data(using:.utf8)!, withName: key)
                }
            }, to: url!, headers: headers).responseJSON { (response) in
                switch response.result {
                case .success:
                    do {
                        let json = try JSON (data: response.data!)
                        let dictJSON = cleanJsonToObject(json.dictionaryObject as AnyObject) as! [String:Any]
                        completion("\(dictJSON["message"]!)")
                    } catch {
                        completion("Error From API")
                    }
                    break
                case .failure(let error):
                    completion("\(error.localizedDescription)")
                    break
                }
            }
        } else {
            completion("Connect Your Device with Internet")
        }
        
    }

}

func cleanJsonToObject(_ data : AnyObject) -> AnyObject {
    let jsonObjective : Any = data
    if jsonObjective is NSArray {
        let jsonResult : NSArray = (jsonObjective as? NSArray)!
        let array: NSMutableArray = NSMutableArray(array: jsonResult)
        for  i in stride(from: array.count-1, through: 0, by: -1) {
            let a : AnyObject = array[i] as AnyObject;
            
            if a as! NSObject == NSNull(){
                array.removeObject(at: i)
            } else {
                array[i] = cleanJsonToObject(a)
            }
        }
        return array;
    } else if jsonObjective is NSDictionary  {
        let jsonResult : Dictionary = (jsonObjective as? Dictionary<String, AnyObject>)!
        let dictionary: NSMutableDictionary = NSMutableDictionary(dictionary: jsonResult)
        for  key in dictionary.allKeys {
            let  d : AnyObject = dictionary[key as! NSCopying]! as AnyObject
            if d as! NSObject == NSNull(){
                dictionary[key as! NSCopying] = ""
            } else {
                dictionary[key as! NSCopying] = cleanJsonToObject(d )
            }
        }
        return dictionary;
    } else {
        return jsonObjective as AnyObject;
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
    
}



