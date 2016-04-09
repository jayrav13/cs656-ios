//
//  ConnectionsListViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/7/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import SwiftQRCode

class ConnectionsListViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // TableView and JSON data
    var tableView : UITableView!
    var data : JSON!
    
    // UIButton elements to be embedded into UIBarButtonItem
    var settingsButton : UIButton!
    var cameraButton : UIButton!
    
    // UIBarButtonItem elements
    var cameraBarButtonItem : UIBarButtonItem!
    var settingsBarButtonItem : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set background color, navigation bar style
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.title = "Connections"
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "AppleSDGothicNeo-Light", size: 24)!
        ]
        
        // Set variable for data
        self.data = []
        
        // Set up UITableView
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.alpha = 0
        self.view.addSubview(self.tableView)
        
        // Set up camera button - button and barbuttonitem
        self.cameraButton = UIButton(type: UIButtonType.Custom)
        self.cameraButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        self.cameraButton.setImage(UIImage(named: "compact-camera-filled-50"), forState: UIControlState.Normal)
        self.cameraButton.addTarget(self, action: "cameraButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.cameraBarButtonItem = UIBarButtonItem(customView: self.cameraButton)
        self.cameraBarButtonItem.style = UIBarButtonItemStyle.Plain
        self.navigationItem.leftBarButtonItem = self.cameraBarButtonItem
        
        // Set up settings button - button and barbuttonitem
        self.settingsButton = UIButton(type: UIButtonType.Custom)
        self.settingsButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        self.settingsButton.setImage(UIImage(named: "settings-filled-50"), forState: UIControlState.Normal)
        self.settingsButton.addTarget(self, action: "settingsButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.settingsBarButtonItem = UIBarButtonItem(customView: self.settingsButton)
        self.settingsBarButtonItem.style = UIBarButtonItemStyle.Plain
        self.navigationItem.rightBarButtonItem = self.settingsBarButtonItem
        
        // Show toolbar, change back button title
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Get user connections
        self.getConnections()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // tableView delegate functions
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = data["response"][indexPath.row]["name"].stringValue
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        cell.detailTextLabel?.text = data["response"][indexPath.row]["company"]["company_name"].stringValue
        cell.detailTextLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 16)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data["response"].count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    // get user data via the API
    func getConnections() {
        API.relationshipList { (success, data) -> Void in
            if(success) {
                // when done, set new data, show tableView and
                self.data = data
                self.tableView.reloadData()
                self.tableView.alpha = 1
            }
            else {
                // Error getting data
                print("Uh oh")
            }
        }
    }
    
    // button listener - cameraButton
    func cameraButtonPressed(sender : UIButton) {
        
        let actionSheet : UIAlertController = UIAlertController(title: "QR Code", message: "What would you like to do?", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Show QR Code", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.navigationController?.pushViewController(DisplayQRCodeViewController(), animated: true)
        }))
    
        actionSheet.addAction(UIAlertAction(title: "Scan QR Code", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let scanner = QRCode()
            scanner.prepareScan(self.view, completion: { (stringValue) -> () in
                print(stringValue)
            })
            scanner.scanFrame = self.view.bounds
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
        }))
        
        self.presentViewController(actionSheet, animated: true) { () -> Void in
            
        }
        
    }
    
    // button listener - settingsButton
    func settingsButtonPressed(sender : UIButton) {
        API.getUser { (success, data) -> Void in
            if(success) {
                let svc : SettingsViewController = SettingsViewController()
                svc.data = data
                self.navigationController?.pushViewController(svc, animated: true)
            }
            else {
                self.presentViewController(Standard.generateAlert("Error", message: "User data could not be loaded."), animated: true, completion: { () -> Void in
                    
                })
            }
        }
        
    }
    
    
    
}