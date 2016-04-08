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
    
    var tableView : UITableView!
    var data : JSON!
    
    var cameraBarButtonItem : UIBarButtonItem!
    var settingsBarButtonItem : UIBarButtonItem!
    
    var settingsButton : UIButton!
    var cameraButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "Connections"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.data = []
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.alpha = 0
        self.view.addSubview(self.tableView)
        
        self.cameraButton = UIButton(type: UIButtonType.Custom)
        self.cameraButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        self.cameraButton.setImage(UIImage(named: "compact-camera-filled-50"), forState: UIControlState.Normal)
        self.cameraButton.addTarget(self, action: "cameraButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.cameraBarButtonItem = UIBarButtonItem(customView: self.cameraButton)
        self.cameraBarButtonItem.style = UIBarButtonItemStyle.Plain
        self.cameraBarButtonItem.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = self.cameraBarButtonItem
        
        self.settingsButton = UIButton(type: UIButtonType.Custom)
        self.settingsButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        self.settingsButton.setImage(UIImage(named: "settings-filled-50"), forState: UIControlState.Normal)
        self.settingsButton.addTarget(self, action: "settingsButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.settingsBarButtonItem = UIBarButtonItem(customView: self.settingsButton)
        self.settingsBarButtonItem.style = UIBarButtonItemStyle.Plain
        self.navigationItem.rightBarButtonItem = self.settingsBarButtonItem
        
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.getConnections()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = data["response"][indexPath.row]["name"].stringValue
        cell.textLabel?.font = UIFont(name: ".SFUIText-Medium", size: 18)
        cell.detailTextLabel?.text = data["response"][indexPath.row]["company"]["company_name"].stringValue
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data["response"].count + 50
    }
    
    func getConnections() {
        API.relationshipList { (success, data) -> Void in
            if(success) {
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
    
    func settingsButtonPressed(sender : UIButton) {
        print("Test")
    }
    
}