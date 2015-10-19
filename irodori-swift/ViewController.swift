//
//  ViewController.swift
//  irodori-swift
//
//  Created by Shotaro Osaki on 2015/10/18.
//  Copyright © 2015年 chabolab. All rights reserved.
//

import UIKit
import GPUImage
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    let imagePicture = GPUImagePicture(image: UIImage(named: "dummy"))
    let stillCamera = GPUImageStillCamera()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = GPUImageView.init(frame: self.view.frame)
        self.view.addSubview(imageView)
        
        let irodoriFilter = GPUImageIrodoriFilter()
        irodoriFilter.setHue(340.0, max: 365.0)
        irodoriFilter.setBr(0.4, max: 1.0)
        irodoriFilter.setSat(0.5, max: 1.0)
        irodoriFilter.addTarget(imageView)
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            imagePicture.addTarget(irodoriFilter)
            imagePicture.processImage()
        #else
            stillCamera.outputImageOrientation = .Portrait
            stillCamera.shouldSmoothlyScaleOutput = true
            stillCamera.addTarget(irodoriFilter)
            stillCamera.startCameraCapture()
        #endif
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

