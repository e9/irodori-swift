//
//  TakePhotoViewController.swift
//  irodori-swift
//
//  Created by Shotaro Osaki on 2015/10/18.
//  Copyright © 2015年 chabolab. All rights reserved.
//

import UIKit
import GPUImage
import Alamofire
import SwiftyJSON




class TakePhotoViewController: UIViewController {
    let imagePicture = GPUImagePicture(image: UIImage(named: "dummy"))
    let stillCamera = GPUImageStillCamera();
    let cropFilter = GPUImageCropFilter(cropRegion: CGRectMake(0, 0, 1, 0.75))
    let irodoriFilter = GPUImageIrodoriFilter()
    
    @IBOutlet weak var retakePhotoButton: UIButton!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var imageView: GPUImageView!
    
    
    var isPhotoTaken:Bool = false {
        didSet{
            if isPhotoTaken {
                retakePhotoButton.enabled = true
                takePhotoButton.enabled = false
            }else{
                retakePhotoButton.enabled = false
                takePhotoButton.enabled = true
            }
        }
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startCamera();
        /*
         Alamofire
         .request(.GET, "http://irodori-server.dev/photos/red.json")
         .validate()
         .responseJSON { response in
         let json = JSON(response.result.value!)
         print(json[0]["user"]["name"])
         }
         */
    }
    
    
    //on Shutter touched
    @IBAction func shutterTouchUpInside(sender: AnyObject) {
        
        if isPhotoTaken==false {
            
            stillCamera.capturePhotoAsImageProcessedUpToFilter(irodoriFilter) { (image, error) in
                print("takephoto");
                
                self.suspendCamera()
                self.isPhotoTaken = true
                
            }
        }else{
            
        }
        
    }
    
    // on Retake touched
    @IBAction func touchRetake(sender: AnyObject) {
        self.isPhotoTaken = false
        self.resumeCamera()
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "takePhoto"{
            print("segue prapare");
            let nextViewController:PhotoEditViewController = segue.destinationViewController as! PhotoEditViewController;
            nextViewController.gpuImage = sender as? GPUImagePicture;
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // camera initialization
    func startCamera(){
        irodoriFilter.setHue(340.0, max: 365.0)
        irodoriFilter.setBr(0.4, max: 1.0)
        irodoriFilter.setSat(0.5, max: 1.0)
        irodoriFilter.addTarget(imageView)
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            imagePicture.addTarget(irodoriFilter)
            imagePicture.processImage()
        #else
            stillCamera.outputImageOrientation = .Portrait;
            stillCamera.shouldSmoothlyScaleOutput = true;
            irodoriFilter.forceProcessingAtSizeRespectingAspectRatio(imageView.bounds.size);
            
            stillCamera.addTarget(cropFilter);
            cropFilter.addTarget(irodoriFilter);
            stillCamera.startCameraCapture();
        #endif
        
    }
    
    func suspendCamera(){
        stillCamera.stopCameraCapture();
    }
    
    func resumeCamera(){
        stillCamera.startCameraCapture();
        
    }
    
    func stopCamera(){
        stillCamera.stopCameraCapture();
        stillCamera.removeAllTargets();
        stillCamera.removeInputsAndOutputs();
        imageView.endProcessing();
        
    }
    
    //Change focus/exposure to designated point
    func setFocusandExposure(pointofInterest:CGPoint)->(){
        do{
            try stillCamera.inputCamera.lockForConfiguration()
            
            if stillCamera.inputCamera.isFocusModeSupported(AVCaptureFocusMode.AutoFocus){
                stillCamera.inputCamera.focusPointOfInterest = pointofInterest;
                stillCamera.inputCamera.focusMode = AVCaptureFocusMode.AutoFocus;
            }
            
            if stillCamera.inputCamera.isExposureModeSupported(AVCaptureExposureMode.AutoExpose){
                stillCamera.inputCamera.exposurePointOfInterest = pointofInterest;
                stillCamera.inputCamera.exposureMode = AVCaptureExposureMode.AutoExpose;
            }
            
        }catch{
            // err handling
        }
        
        stillCamera.inputCamera.unlockForConfiguration()
    }
    
    // detect touchEnd on Screen and conver it to ImageView's screen
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let x:CGFloat? = touches.first?.locationInView(self.imageView).x
        let y:CGFloat? = touches.first?.locationInView(self.imageView).x
        
        
        //Convert CGRect to float for focus
        let px = x!/self.imageView.frame.size.width;
        let py = y!/self.imageView.frame.size.height;
        
        let pointofInterest=CGPointMake(py,1.0-px);
        
        if(px<=1 && py<=1){
            self.setFocusandExposure(pointofInterest)
        }
    }
    
    
    
}

