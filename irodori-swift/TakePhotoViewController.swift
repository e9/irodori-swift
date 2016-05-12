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
    
    


}

