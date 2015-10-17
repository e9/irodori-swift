//
//  ViewController.swift
//  irodori-swift
//
//  Created by Shotaro Osaki on 2015/10/18.
//  Copyright © 2015年 chabolab. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let sourceImage = UIImage(named: "dummy")
        let imagePicture = GPUImagePicture(image: sourceImage)
        let irodoriFilter = GPUImageIrodoriFilter()
        
        irodoriFilter.setHue(340.0, max: 365.0)
        irodoriFilter.setBr(0.4, max: 1.0)
        irodoriFilter.setSat(0.5, max: 1.0)
        imagePicture.addTarget(irodoriFilter)
        imagePicture.processImage()
        
        let destinationImage = irodoriFilter.imageByFilteringImage(sourceImage)
        self.view.addSubview(UIImageView(image: destinationImage))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

