//
//  SocialLoginViewController.swift
//  irodori-swift
//
//  Created by Shotaro Osaki on H28/05/03.
//  Copyright © 平成28年 chabolab. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SocialLoginViewController: UIViewController {
    let button_fb = UIButton()
    let button_tw = UIButton()

    enum BtnTag: Int {
        case Facebook = 1, Twitter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.Vertical
        stackView.distribution = UIStackViewDistribution.EqualSpacing
        stackView.alignment = UIStackViewAlignment.Center
        stackView.spacing = 30
        
        button_fb.setTitle("facebook", forState: .Normal)
        button_fb.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button_fb.addTarget(self, action: #selector(self.tapped(_:)), forControlEvents:.TouchUpInside)
        button_fb.tag = BtnTag.Facebook.rawValue
        stackView.addArrangedSubview(button_fb)
        
        button_tw.setTitle("twitter", forState: .Normal)
        button_tw.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button_tw.addTarget(self, action: #selector(self.tapped(_:)), forControlEvents:.TouchUpInside)
        button_tw.tag = BtnTag.Twitter.rawValue
        stackView.addArrangedSubview(button_tw)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapped(sender: AnyObject) {
        let btag = BtnTag(rawValue: sender.tag)!

        switch btag {
        case BtnTag.Facebook:
            let loginManager = FBSDKLoginManager()
            
            loginManager.logInWithReadPermissions(["public_profile", "email"], fromViewController: self, handler: { (result, error) -> Void in
                
                if error != nil {
                    print(FBSDKAccessToken.currentAccessToken())
                } else if result.isCancelled {
                    print("Cancelled")
                } else {
                    print("LoggedIn")
                    
                    print(result.token.userID)
                    print(result.token.tokenString)
                    
                    let req = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email,name"])
                    req.startWithCompletionHandler({ (connection, result, error) -> Void in
                        if error == nil {
                            print("result \(result)")
                        }
                    })
                    
                }
            })
        case BtnTag.Twitter: break
            
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
