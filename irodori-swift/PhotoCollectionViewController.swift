//
//  PhotoCollectionViewController.swift
//  irodori-swift
//
//  Created by Chabose on 2016/05/03.
//  Copyright © 2016年 chabolab. All rights reserved.
//

import UIKit

class PhotoCollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    //define maxImagesize per one image
    private let maxCellsize:CGFloat = 120.0
    private let reuseIdentifier = "Cell"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("photoView did load");
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView!.delegate = self;
        self.collectionView!.dataSource = self;
        
       
        
        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated);
        print("photoView will appear");
        
    }

    //For detecting device rotation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator);
        self.collectionViewLayout.invalidateLayout();
        
    }
 
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 40
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
    
        // Configure the cell
        let imageviewCell:UIImageView = cell.viewWithTag(1) as! UIImageView;

        
        //load dummy image
        //TODO: load dynamic images
        imageviewCell.image = UIImage(named: "dummy");
        
        //print(cell.constraints);
     

        
        return cell
    }
    
func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    // Calculate number of columns from maxCellsize
    
    let columns:Int = Int(floor(UIScreen.mainScreen().bounds.width / maxCellsize));
    print("columns \(columns)");
    
    let cellSize:CGFloat = UIScreen.mainScreen().bounds.width/CGFloat(columns);
    print("size \(cellSize)");

    return CGSizeMake(cellSize, cellSize);
    
    }
    

    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        print("index:\(indexPath)");
        
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil);
        let nextViewController:PhotoSingleCollectionViewController = storyboard.instantiateViewControllerWithIdentifier("photo") as! PhotoSingleCollectionViewController;
        
        //set photoIndex for nextview(1x1)
        nextViewController.photoIndex = indexPath.item;
        
        self.presentViewController(nextViewController, animated: true, completion: nil);
        
        
        return true
    }
 

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
