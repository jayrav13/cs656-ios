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
    
    var nameLabel : UILabel!
    var companyLabel : UILabel!
    
    var linkedinButton : UIButton!
    var twitterButton : UIButton!
    var resumeButton : UIButton!
    var websiteButton : UIButton!
    
    var toolbarLabel : UILabel!
    
    var data : JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.nameLabel = UILabel()
        self.nameLabel.frame = CGRect(x: 0, y: Standard.screenHeight * 0.15, width: Standard.screenWidth, height: Standard.screenHeight * 0.1)
        self.nameLabel.text = self.data["name"].stringValue
        self.nameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 48)
        self.nameLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.nameLabel)
        
        self.linkedinButton = UIButton()
        self.linkedinButton.frame = CGRect(x: Standard.screenWidth * 0.5 - Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.5 - Standard.screenWidth * 0.25, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.linkedinButton.setImage(UIImage(named: "linkedin-filled-100"), forState: UIControlState.Normal)
        self.linkedinButton.alpha = self.data["linkedin"].stringValue.characters.count > 0 ? 1.0 : 0.25
        self.linkedinButton.addTarget(self, action: "openLinkedInURL:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.linkedinButton)
        
        self.twitterButton = UIButton()
         self.twitterButton.frame = CGRect(x: Standard.screenWidth * 0.5 + Standard.screenWidth * 0.05, y: Standard.screenHeight * 0.5 - Standard.screenWidth * 0.25, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.twitterButton.setImage(UIImage(named: "twitter-filled-100"), forState: UIControlState.Normal)
        self.twitterButton.alpha = self.data["twitter"].stringValue.characters.count > 0 ? 1.0 : 0.25
        self.twitterButton.addTarget(self, action: "openTwitterURL:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.twitterButton)
        
        self.resumeButton = UIButton()
        self.resumeButton.frame = CGRect(x: Standard.screenWidth * 0.5 - Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.5 + Standard.screenWidth * 0.05, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.resumeButton.setImage(UIImage(named: "copy-filled-100"), forState: UIControlState.Normal)
        self.resumeButton.alpha = self.data["resume"].stringValue.characters.count > 0 ? 1.0 : 0.25
        self.resumeButton.addTarget(self, action: "openResumeURL:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.resumeButton)
        
        self.websiteButton = UIButton()
        self.websiteButton.frame = CGRect(x: Standard.screenWidth * 0.5 + Standard.screenWidth * 0.05, y: Standard.screenHeight * 0.5 + Standard.screenWidth * 0.05, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.websiteButton.setImage(UIImage(named: "domain-filled-100"), forState: UIControlState.Normal)
        self.websiteButton.alpha = self.data["website"].stringValue.characters.count > 0 ? 1.0 : 0.25
        self.websiteButton.addTarget(self, action: "openWebsiteURL:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.websiteButton)
        
        // create flexSpace button
        let flexibleSpace : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        // create toolbarLabel for "last updated"
        self.toolbarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 50))
        self.toolbarLabel.text = self.data["pivot"]["created_at"].stringValue.characters.count > 0 ? "Connected On: \(self.data["pivot"]["created_at"].stringValue)" : ""
        self.toolbarLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        self.toolbarLabel.textAlignment = NSTextAlignment.Center
        self.toolbarItems = [flexibleSpace, UIBarButtonItem(customView: self.toolbarLabel), flexibleSpace]
        
        print(self.data)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openLinkedInURL(sender : UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.linkedin.com/in/" + data["linkedin"].stringValue)!)
    }
    
    func openTwitterURL(sender : UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.twitter.com/" + data["twitter"].stringValue)!)
    }
    
    func openResumeURL(sender : UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: data["resume"].stringValue)!)
    }
    
    func openWebsiteURL(sender : UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: data["website"].stringValue)!)
    }
    
}
