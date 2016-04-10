//
//  ProfileViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/9/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class ProfileViewController : UIViewController {
    
    var linkedinButton : UIButton!
    var twitterButton : UIButton!
    var resumeButton : UIButton!
    var websiteButton : UIButton!
    
    var data : JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.linkedinButton = UIButton()
        self.linkedinButton.frame = CGRect(x: Standard.screenWidth * 0.5 - Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.5 - Standard.screenWidth * 0.25, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.linkedinButton.setImage(UIImage(named: "linkedin-filled-100"), forState: UIControlState.Normal)
        self.linkedinButton.alpha = self.data["linkedin"].stringValue.characters.count > 0 ? 1.0 : 0.5
        self.linkedinButton.addTarget(self, action: "openURL:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.linkedinButton)
        
        self.twitterButton = UIButton()
         self.twitterButton.frame = CGRect(x: Standard.screenWidth * 0.5 + Standard.screenWidth * 0.05, y: Standard.screenHeight * 0.5 - Standard.screenWidth * 0.25, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.twitterButton.setImage(UIImage(named: "twitter-filled-100"), forState: UIControlState.Normal)
        self.twitterButton.alpha = self.data["twitter"].stringValue.characters.count > 0 ? 1.0 : 0.5
        self.view.addSubview(self.twitterButton)
        
        self.resumeButton = UIButton()
        self.resumeButton.frame = CGRect(x: Standard.screenWidth * 0.5 - Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.5 + Standard.screenWidth * 0.05, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.resumeButton.setImage(UIImage(named: "copy-filled-100"), forState: UIControlState.Normal)
        self.resumeButton.alpha = self.data["resume"].stringValue.characters.count > 0 ? 1.0 : 0.5
        self.view.addSubview(self.resumeButton)
        
        self.websiteButton = UIButton()
        self.websiteButton.frame = CGRect(x: Standard.screenWidth * 0.5 + Standard.screenWidth * 0.05, y: Standard.screenHeight * 0.5 + Standard.screenWidth * 0.05, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.websiteButton.setImage(UIImage(named: "domain-filled-100"), forState: UIControlState.Normal)
        self.websiteButton.alpha = self.data["website"].stringValue.characters.count > 0 ? 1.0 : 0.5
        self.view.addSubview(self.websiteButton)
        
        print(self.data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openURL(sender : UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: data["linkedin"].stringValue)!)
    }
    
}
