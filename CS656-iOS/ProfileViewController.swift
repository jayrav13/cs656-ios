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
import Firebase

class ProfileViewController : UIViewController, LGChatControllerDelegate {
    
    var nameLabel : UILabel!
    var companyLabel : UILabel!
    
    var linkedinButton : UIButton!
    var twitterButton : UIButton!
    var resumeButton : UIButton!
    var websiteButton : UIButton!
    
    var chatButton : UIButton!
    var toolbarLabel : UILabel!
    
    var data : JSON!
    var currentUser: JSON!
    
    var chatController : LGChatController!
    var firebase : Firebase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.nameLabel = UILabel()
        self.nameLabel.frame = CGRect(x: 0, y: Standard.screenHeight * 0.15, width: Standard.screenWidth, height: Standard.screenHeight * 0.1)
        self.nameLabel.text = self.data["name"].stringValue
        self.nameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 48)
        self.nameLabel.textAlignment = NSTextAlignment.Center
        self.nameLabel.adjustsFontSizeToFitWidth = true
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
        
        self.chatButton = UIButton()
        self.chatButton.frame = CGRect(x: Standard.screenWidth * 0.5 - Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.5 + Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.2, height: Standard.screenWidth * 0.2)
        self.chatButton.setImage(UIImage(named: "speech-bubble-filled-100"), forState: UIControlState.Normal)
        self.chatButton.addTarget(self, action: "chatButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.chatButton)
        
        self.chatController = LGChatController()
        self.firebase = Firebase(url: "https://ihlp656-njit.firebaseio.com/")
        
        // create flexSpace button
        let flexibleSpace : UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        // create toolbarLabel for "last updated"
        self.toolbarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 50))
        self.toolbarLabel.text = self.data["pivot"]["created_at"].stringValue.characters.count > 0 ? "Connected on: \(self.data["pivot"]["created_at"].stringValue)" : ""
        self.toolbarLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
        self.toolbarLabel.textAlignment = NSTextAlignment.Center
        self.toolbarItems = [flexibleSpace, UIBarButtonItem(customView: self.toolbarLabel), flexibleSpace]
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
    
    func chatButtonPressed(sender : UIButton) {
        self.chatController.title = "Chat with \(self.data["name"].stringValue)"
        self.chatController.delegate = self
        API.getUser { (success, data) in
            if(success) {
                self.firebase.observeEventType(.Value, withBlock: { snapshot in
                    let from : Int = (snapshot.value["from"] as? Int)!
                    let to : Int = (snapshot.value["to"] as? Int)!
                    let message : String = (snapshot.value["message"] as? String)!
                    if(from == self.data["id"].intValue && to == self.currentUser["id"].intValue) {
                        self.chatController.addNewMessage(LGChatMessage(content: message, sentBy: .Opponent))
                    }
                })
                
                self.currentUser = data["response"]
                self.navigationController?.pushViewController(self.chatController, animated: true)
            }
            else {
                
            }
        }
        
    }
    
    func chatController(chatController: LGChatController, didAddNewMessage message: LGChatMessage) {
        
    }
    
    func shouldChatController(chatController: LGChatController, addMessage message: LGChatMessage) -> Bool {
        print(message.content)
        self.firebase.setValue([
            "from" : currentUser["id"].intValue,
            "to" : data["id"].intValue,
            "message" : message.content,
            "time" : NSDate().timeIntervalSince1970
        ])
        return true
    }
    
}
