

//  CameraViewController.swift
//  YOLO


//  Created by Boons&Blessings Apps on 03/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.


import UIKit
import AVFoundation

var videoRecorded:URL!

class CameraViewController: UIViewController, AVCapturePhotoCaptureDelegate, AVCaptureFileOutputRecordingDelegate {
    
    var captureSession: AVCaptureSession!
    
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var previewView:UIView!
    @IBOutlet weak var captureImageView:UIImageView!
    
    @IBOutlet weak var didTakePhoto:UIButton!
    @IBOutlet weak var viewRetake:UIView!
    @IBOutlet weak var viewSwitch:UIView!
    @IBOutlet weak var viewCameraType:UIView!
    @IBOutlet weak var btnPicture:UIButton!
    @IBOutlet weak var btnVideo:UIButton!
    @IBOutlet weak var lblRecordingTime:UILabel!
    
    var isBackCamera = true
    var isImage = true
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewCameraType.layer.cornerRadius = viewCameraType.frame.height/2
        viewCameraType.clipsToBounds = true
        
        didTakePhoto.isHidden = false
        captureImageView.isHidden = true
        viewRetake.isHidden = true
        viewSwitch.isHidden = false
        lblRecordingTime.isHidden = true
        
        funcCheckCameraPermission()
    }
    
    func funcCheckCameraPermission() {
        AVCaptureDevice.requestAccess(for:.video, completionHandler: { (granted: Bool) -> Void in
            if granted {
                DispatchQueue.main.async {
                    self.funcBackCamera()
                }
            } else {
                DispatchQueue.main.async {
                    self.funcOpenAppSettings("needs to access your camera")
                }
            }
        })
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let _ = captureSession {
            self.captureSession.stopRunning()
        }
    }
    
    @IBAction func btnIsImageVideo(_ sender:UIButton) {
        isImage = !isImage
        
        captureSession.stopRunning()
        
        isImage ? funcBackCamera() : funcSetUpVideoBack()
        lblRecordingTime.isHidden = isImage ? true : false
        
        btnPicture.backgroundColor = isImage
            ? hexStringToUIColor("0FF707").withAlphaComponent(0.5)
            : hexStringToUIColor("020518").withAlphaComponent(0.5)
        
        btnVideo.backgroundColor = !isImage
            ? hexStringToUIColor("0FF707").withAlphaComponent(0.5)
            : hexStringToUIColor("020518").withAlphaComponent(0.5)
    }
    
    func funcFrontCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard
            let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func funcBackCamera() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard
            let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.previewView.bounds
            }
            
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard
            let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        captureImageView.image = image
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if let imageClicked = self.captureImageView.image {
                imgSelected_Clicked = imageClicked
                self.pushViewController("ClickedViewController", k_MainStoryBoad)
            }
        }
        
    }
    
    @IBAction func didTakePhoto(_ sender: Any) {
        if isImage {
            let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
            stillImageOutput.capturePhoto(with: settings, delegate: self)
            
            didTakePhoto.isHidden = true
            captureImageView.isHidden = false
            viewRetake.isHidden = false
            viewSwitch.isHidden = true
        } else {
            movieOutput.isRecording ? stopRecording() :  startRecording()
        }
    }
    
    @IBAction func btnSwitch(_ sender: Any) {
        stopRecording()
        captureSession.stopRunning()
        captureImageView.image = UIImage (named:"")
        
        isBackCamera = !isBackCamera
        
        isImage ? (isBackCamera ? funcBackCamera() : funcFrontCamera())
            : (isBackCamera ? funcSetUpVideoBack() : funcFrontCamera())
    }
    
    @IBAction func btnRetake(_ sender: Any) {
        didTakePhoto.isHidden = false
        captureImageView.isHidden = true
        viewRetake.isHidden = true
        viewSwitch.isHidden = false
    }
    
    @IBAction func btnSkip(_ sender: Any) {
        func_API_LogWorkout()
    }
    
    @IBAction func btnGallery(_ sender: Any) {
        pushViewController("GalleryViewController", k_MainStoryBoad)
    }
    
//    MARK:- Video Sett Up
//    @IBOutlet weak var camPreview: UIView!
    
    let cameraButton = UIView()
    let movieOutput = AVCaptureMovieFileOutput()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var activeInput: AVCaptureDeviceInput!
    
    var outputURL:URL!
    
    var timerRecordedVideo = Timer()
    var countRecordedVideo = 0
    
    func funcStartTimer() {
        timerRecordedVideo = Timer.scheduledTimer(timeInterval:1.0, target:self, selector:#selector(funcRecordedTime), userInfo: nil, repeats: true)
    }
    
    func funcStopTimer() {
        timerRecordedVideo.invalidate()
        countRecordedVideo = 0
    }
    
    // must be internal or public.
    @objc func funcRecordedTime() {
        countRecordedVideo += 1
        lblRecordingTime.text = "\(countRecordedVideo)"
        
        if countRecordedVideo > 10 {
            stopRecording()
        }
    }
    
    func funcSetUpVideoBack() {
        if setupSessionBack() {
            setupPreview()
            startSession()
        }
    }
    
    func funcSetUpVideoFront() {
        if setupSessionFront(){
            setupPreview()
            startSession()
        }
    }
    
    func setupPreview() {
        // Configure previewLayer
//        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
//        previewLayer.frame = previewView.frame
//        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
//
//        previewView.layer.addSublayer(previewLayer)
        
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { //[weak self] in
            self.captureSession.startRunning()
            
            DispatchQueue.main.async {
                self.previewLayer.frame = self.previewView.bounds
            }
            
        }
    }
    
//    MARK:- Setup Camera
    func setupSessionFront() -> Bool {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        // Setup Camera
        
        guard
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
            else {
                print("Unable to access back camera!")
                return false
        }
        
//        let camera = AVCaptureDevice.default(for: AVMediaType.video)!
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                activeInput = input
            }
        } catch {
            print("Error setting device video input: \(error)")
            return false
        }
        
        // Setup Microphone
        let microphone = AVCaptureDevice.default(for: AVMediaType.audio)!
        
        do {
            let micInput = try AVCaptureDeviceInput(device: microphone)
            if captureSession.canAddInput(micInput) {
                captureSession.addInput(micInput)
            }
        } catch {
            print("Error setting device audio input: \(error)")
            return false
        }
        
        
        // Movie output
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
        
        return true
    }
    
    func setupSessionBack() -> Bool {
            captureSession = AVCaptureSession()
            captureSession.sessionPreset = AVCaptureSession.Preset.high
            // Setup Camera
            
        guard
            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
            else {
                print("Unable to access back camera!")
                return false
        }
            
    //        let camera = AVCaptureDevice.default(for: AVMediaType.video)!
            do {
                let input = try AVCaptureDeviceInput(device: camera)
                if captureSession.canAddInput(input) {
                    captureSession.addInput(input)
                    activeInput = input
                }
            } catch {
                print("Error setting device video input: \(error)")
                return false
            }
            
            // Setup Microphone
            let microphone = AVCaptureDevice.default(for: AVMediaType.audio)!
            
            do {
                let micInput = try AVCaptureDeviceInput(device: microphone)
                if captureSession.canAddInput(micInput) {
                    captureSession.addInput(micInput)
                }
            } catch {
                print("Error setting device audio input: \(error)")
                return false
            }
            
            
            // Movie output
            if captureSession.canAddOutput(movieOutput) {
                captureSession.addOutput(movieOutput)
            }
            
            return true
        }
    
    func setupCaptureMode(_ mode: Int) {
        // Video Mode
    }
    
    //MARK:- Camera Session
    func startSession() {
        
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }
    
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            orientation = AVCaptureVideoOrientation.landscapeLeft
        case .portraitUpsideDown:
            orientation = AVCaptureVideoOrientation.portraitUpsideDown
        default:
            orientation = AVCaptureVideoOrientation.landscapeRight
        }
        
        return orientation
    }
    
    @objc func startCapture() {
        startRecording()
    }
    
    //EDIT 1: I FORGOT THIS AT FIRST
    
    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
        
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
        
        return nil
    }
    
    func startRecording() {
        if movieOutput.isRecording == false {
            let connection = movieOutput.connection(with: AVMediaType.video)
            
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            
            let device = activeInput.device
            
            if (device.isSmoothAutoFocusSupported) {
                
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
                
            }
            
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
          
            lblRecordingTime.isHidden = false
            funcStartTimer()
            viewSwitch.isHidden = true
        } else {
            stopRecording()
        }
        
    }
    
    func stopRecording() {
        if movieOutput.isRecording == true {
            movieOutput.stopRecording()
            lblRecordingTime.isHidden = true
            viewSwitch.isHidden = false
            funcStopTimer()
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if (error != nil) {
            print("Error recording movie: \(error!.localizedDescription)")
        } else {
            videoRecorded = outputURL! as URL
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                self.pushViewController("VideoRecordedViewController", k_MainStoryBoad)
            }
        }
    }
}



import UIKit
import AVFoundation

class VideoViewControllers: UIViewController, AVCaptureFileOutputRecordingDelegate {
    @IBOutlet weak var camPreview: UIView!
    
    let cameraButton = UIView()
    let captureSession = AVCaptureSession()
    let movieOutput = AVCaptureMovieFileOutput()
    var previewLayer: AVCaptureVideoPreviewLayer!
    var activeInput: AVCaptureDeviceInput!
    
    var outputURL:URL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if setupSession() {
            setupPreview()
            startSession()
        }
        
        cameraButton.isUserInteractionEnabled = true
        
        let cameraButtonRecognizer = UITapGestureRecognizer(target: self, action: #selector(startCapture))
        
        cameraButton.addGestureRecognizer(cameraButtonRecognizer)
        cameraButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        cameraButton.backgroundColor = UIColor.red
        camPreview.addSubview(cameraButton)
    }
    
    @IBAction func btnProfile(_ sender:UIButton) {
        self.navigationController!.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name (rawValue: "selectedIndex"), object: nil)
    }

    
    func setupPreview() {
        // Configure previewLayer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = camPreview.bounds
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        camPreview.layer.addSublayer(previewLayer)
    }
    

    func setupSession() -> Bool {
        captureSession.sessionPreset = AVCaptureSession.Preset.high
        // Setup Camera
        
        let camera = AVCaptureDevice.default(for: AVMediaType.video)!
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
                activeInput = input
            }
        } catch {
            print("Error setting device video input: \(error)")
            return false
        }
        
        // Setup Microphone
        let microphone = AVCaptureDevice.default(for: AVMediaType.audio)!
        
        do {
            let micInput = try AVCaptureDeviceInput(device: microphone)
            if captureSession.canAddInput(micInput) {
                captureSession.addInput(micInput)
            }
        } catch {
            print("Error setting device audio input: \(error)")
            return false
        }
        
        
        // Movie output
        if captureSession.canAddOutput(movieOutput) {
            captureSession.addOutput(movieOutput)
        }
        
        return true
    }
    
    
    func setupCaptureMode(_ mode: Int) {
        // Video Mode
        
    }
    
    //MARK:- Camera Session
    func startSession() {
        
        if !captureSession.isRunning {
            videoQueue().async {
                self.captureSession.startRunning()
            }
        }
    }
    
    func stopSession() {
        if captureSession.isRunning {
            videoQueue().async {
                self.captureSession.stopRunning()
            }
        }
    }
    
    func videoQueue() -> DispatchQueue {
        return DispatchQueue.main
    }
    
    func currentVideoOrientation() -> AVCaptureVideoOrientation {
        var orientation: AVCaptureVideoOrientation
        
        switch UIDevice.current.orientation {
        case .portrait:
            orientation = AVCaptureVideoOrientation.portrait
        case .landscapeRight:
            orientation = AVCaptureVideoOrientation.landscapeLeft
        case .portraitUpsideDown:
            orientation = AVCaptureVideoOrientation.portraitUpsideDown
        default:
            orientation = AVCaptureVideoOrientation.landscapeRight
        }
        
        return orientation
    }
    
    @objc func startCapture() {
        startRecording()
    }
    
    //EDIT 1: I FORGOT THIS AT FIRST
    
    func tempURL() -> URL? {
        let directory = NSTemporaryDirectory() as NSString
        
        if directory != "" {
            let path = directory.appendingPathComponent(NSUUID().uuidString + ".mp4")
            return URL(fileURLWithPath: path)
        }
        
        return nil
    }
    
    func startRecording() {
        if movieOutput.isRecording == false {
            
            let connection = movieOutput.connection(with: AVMediaType.video)
            
            if (connection?.isVideoOrientationSupported)! {
                connection?.videoOrientation = currentVideoOrientation()
            }
            
            if (connection?.isVideoStabilizationSupported)! {
                connection?.preferredVideoStabilizationMode = AVCaptureVideoStabilizationMode.auto
            }
            
            let device = activeInput.device
            
            if (device.isSmoothAutoFocusSupported) {
                
                do {
                    try device.lockForConfiguration()
                    device.isSmoothAutoFocusEnabled = false
                    device.unlockForConfiguration()
                } catch {
                    print("Error setting configuration: \(error)")
                }
                
            }
            
            //EDIT2: And I forgot this
            outputURL = tempURL()
            movieOutput.startRecording(to: outputURL, recordingDelegate: self)
            
        }
        else {
            stopRecording()
        }
        
    }
    
    func stopRecording() {
        
        if movieOutput.isRecording == true {
            movieOutput.stopRecording()
        }
    }
    
    func capture(_ captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAt fileURL: URL!, fromConnections connections: [Any]!) {
        
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if (error != nil) {
            print("Error recording movie: \(error!.localizedDescription)")
        } else {
            videoRecorded = outputURL! as URL
        }

    }
    
}



extension CameraViewController {
    func func_API_LogWorkout() {
        let dictMealsGrinds = ["meals":meals,"grinds":strGrinds,"compaignID":selectedComapaignID]
        UserDefaults.standard.set(dictMealsGrinds, forKey:k_MealsGrinds)
        
        let param = ["grind_id":grindID,
                     "media_type":"image",
                     "contribution_id":strContributionID]
        let loader = showLoader()
        
        APIFunc.postAPI_Image("log/workout", param, UIImage (named: "logo")!, UIImage (named: "logo")!) { (error,message) in
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
    
}
