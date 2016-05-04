//
//  PhotoSingleCollectionViewController.swift
//  irodori-swift
//
//  Created by Chabose on 2016/05/03.
//  Copyright © 2016年 chabolab. All rights reserved.
//

import UIKit



class PhotoSingleCollectionViewController: PhotoCollectionViewController {
    var photoIndex:NSInteger = 0;

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        
        self.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem: photoIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.None, animated: false);
        
     }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator);
    }
    
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenWidth = UIScreen.mainScreen().bounds.width;
        let screenHeight = UIScreen.mainScreen().bounds.height;
        
        //place max square on the screen
        
        
        return CGSizeMake(screenWidth, screenHeight);
        
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath);

        
        let imageviewCell:UIImageView = cell.viewWithTag(1)! as! UIImageView;
        let commentView:UIView = cell.viewWithTag(2)! as UIView;
        
        
        
        //remove constrains added on the code for supporting rotation change
        //TODO: it would be faster if constraint is created once and switch activate on/off rather than remove/add
        
        
        for constraint in cell.constraints{
            print(constraint.identifier);
            if constraint.identifier == "added"{
                cell.removeConstraint(constraint);
                
            }
        }
        
        // choose shorter side of window and set it as square size constraint
        
        
        //when portrait on any devices
        if cell.frame.width < cell.frame.height{
        
            //make square on top
            let constraint = NSLayoutConstraint(item: imageviewCell, attribute:NSLayoutAttribute.Width , relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Width, multiplier: 1.0, constant: 0)
            constraint.identifier="added";
            
            //commentview on bottom
            let constraint2 = NSLayoutConstraint(item: commentView, attribute:NSLayoutAttribute.Top , relatedBy: NSLayoutRelation.Equal, toItem: imageviewCell, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 5)
            constraint2.identifier="added";
            let constraint3 = NSLayoutConstraint(item: commentView, attribute:NSLayoutAttribute.Left , relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Left , multiplier: 1.0, constant: 0)
            constraint3.identifier="added";
            let constraint4 = NSLayoutConstraint(item: commentView, attribute:NSLayoutAttribute.Width , relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Width , multiplier: 1.0, constant: 0)
            constraint4.identifier="added";
            
          
            cell.addConstraints([constraint,constraint2,constraint3,constraint4]);



            
        }else{ // when landscape
            
            // make square on left
            let constraint=NSLayoutConstraint(item: imageviewCell, attribute:NSLayoutAttribute.Height , relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Height, multiplier: 1.0, constant: 0)
            constraint.identifier="added";
            
            //commentview on right
            let constraint2 = NSLayoutConstraint(item: commentView, attribute:NSLayoutAttribute.Top , relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: 0)
            constraint2.identifier="added";
            let constraint3 = NSLayoutConstraint(item: commentView, attribute:NSLayoutAttribute.Left , relatedBy: NSLayoutRelation.Equal, toItem: imageviewCell, attribute: NSLayoutAttribute.Right , multiplier: 1.0, constant: 5)
            constraint3.identifier="added";
            let constraint4 = NSLayoutConstraint(item: commentView, attribute:NSLayoutAttribute.Right , relatedBy: NSLayoutRelation.Equal, toItem: cell, attribute: NSLayoutAttribute.Right , multiplier: 1.0, constant: 0)
            constraint4.identifier="added";
            
            cell.addConstraints([constraint,constraint2,constraint3,constraint4]);
            
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return false;
        
    }
    
    

}
