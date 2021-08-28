//
//  VideoRecordedViewController.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 08/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftMessageBar

import AVKit
import AVFoundation
import AKMediaViewer

class VideoRecordedViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var videoView:UIView!
    @IBOutlet weak var lblMeals:UILabel!
    @IBOutlet weak var viewStickerImage:UIView!
    
    @IBOutlet weak var btnShareOnFeed:UIButton!
    @IBOutlet weak var player:PlayerView!
    
    var documentController = UIDocumentInteractionController()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    func addVideoPlayer(videoUrl: URL, to view: UIView) {
        let player = AVPlayer(url: videoUrl)
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.sublayers?
            .filter { $0 is AVPlayerLayer }
            .forEach { $0.removeFromSuperlayer() }
        view.layer.addSublayer(layer)
        
        player.play()
    }
    
    @IBAction func btnShareToStory(_ sender:UIButton) {
        
    }
    
    @IBAction func btnShareOnFeed(_ sender:UIButton) {
        
    }
    
    func getScreenshot(_ viewToSnapShot:UIView) -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        viewToSnapShot.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

