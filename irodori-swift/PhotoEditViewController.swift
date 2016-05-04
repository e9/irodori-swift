//
//  PhotoEditViewController.swift
//  irodori-swift
//
//  Created by Chabose on 2016/05/04.
//  Copyright © 2016年 chabolab. All rights reserved.
//

import UIKit
import GPUImage



class PhotoEditViewController: UIViewController {
    internal var gpuImage:GPUImagePicture? = nil
    @IBOutlet var editImageView: GPUImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("edit view loaded");


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        print("view did appear");

        if let gpuImagewpd = gpuImage {
            gpuImagewpd.addTarget(editImageView);
            gpuImagewpd.processImage();
        }
        

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
