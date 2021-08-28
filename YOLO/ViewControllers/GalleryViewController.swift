

//  GalleryViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 03/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import Photos


class GalleryViewController: UIViewController {
    @IBOutlet weak var collPhotos:UICollectionView!
    
    var images = [UIImage]()
    var assets = [PHAsset]()
    
    let page = 50
    var beginIndex = 0
    
    var endIndex = 900
    var allPhotos : PHFetchResult<PHAsset>?
    var loading = false
    var hasNextPage = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        funcPhotosPermission()
    }
    
    @IBAction func btnProfile(_ sender:UIButton) {
        self.navigationController!.dismiss(animated: true, completion: nil)
        
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selectedIndex"), object: nil)
    }
    
    func funcPhotosPermission() {
        AVCaptureDevice.requestAccess(for:.video, completionHandler: { (videoGranted: Bool) -> Void in
            if (videoGranted) {
                AVCaptureDevice.requestAccess(for: AVMediaType.audio, completionHandler: { (audioGranted: Bool) -> Void in
                    if (audioGranted) {
                        
                    } else {
                        
                    }
                })
            } else {
                
            }
        })
        
        PHPhotoLibrary.requestAuthorization { (status) in
            if (status == PHAuthorizationStatus.authorized) {
                self.getImages()
            } else {
                self.funcOpenAppSettings("needs to access your photos")
            }
        }
    }
    
    func getImages() {
        let options = PHFetchOptions()
        options.includeHiddenAssets = true
        allPhotos = PHAsset.fetchAssets(with: .image, options: options)
        
        endIndex = beginIndex + (page - 1)
        if endIndex > allPhotos!.count {
            endIndex = allPhotos!.count - 1
        }
        
        if allPhotos!.count > 0 {
            let arr = Array(beginIndex...endIndex)
            
            let indexSet = IndexSet(arr)
            fetchPhotos(indexSet: indexSet)
        }
        
    }
    
    fileprivate func fetchPhotos(indexSet: IndexSet) {
        if allPhotos!.count == images.count {
            self.hasNextPage = false
            self.loading = false
            
            return
        }
        
        self.loading = true
        
        DispatchQueue.global().async {
            self.allPhotos?.enumerateObjects(at: indexSet, options: NSEnumerationOptions.concurrent, using: { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                imageManager.requestImage(for: asset, targetSize: CGSize(width:500, height:500), contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        if self.images.count < 1500 {
                            self.images.append(image)
                            self.assets.append(asset)
                        }
                    }
                })
                
                if self.images.count - 1 == indexSet.last! {
                    self.loading = false
                    self.hasNextPage = self.images.count != self.allPhotos!.count
                    self.beginIndex =  self.images.count
                }
                
                DispatchQueue.main.async {
                    self.collPhotos.reloadData()
                }
            })
        }
    }
    
}



extension GalleryViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/4
        
        return CGSize (width:width, height:width)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! GalleryCollectionViewCell
        
        cell.imgPicture.image = images[indexPath.row]
                
        cell.btnSelectPicture.tag = indexPath.row
        cell.btnSelectPicture.addTarget(self, action:#selector(btnSelectPicture(_:)), for:.touchUpInside)
        
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let arrayOfVisibleItems = collPhotos.indexPathsForVisibleItems.sorted()
        let lastIndexPath = arrayOfVisibleItems.last
        
        if let lastIndex = lastIndexPath {
            if lastIndex.row == images.count-1 {
                getImages()
            }
        }
    }
    
    @IBAction func btnSelectPicture(_ sender:UIButton) {
        debugPrint(images[sender.tag])
        imgSelected_Clicked = images[sender.tag]
        
        pushViewController("ClickedViewController",k_MainStoryBoad)
    }
    
}


