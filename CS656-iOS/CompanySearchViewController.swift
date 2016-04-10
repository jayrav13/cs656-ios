//
//  CompanySearchViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/9/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

protocol CompanySearchViewControllerDelegate: class {
    func didFinishTask(companyName : String)
}

class CompanySearchViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var data : JSON!
    
    // UIButton elements to be embedded into UIBarButtonItem
    var clearButton : UIButton!
    
    // UIBarButtonItem elements
    var clearBarButtonItem : UIBarButtonItem!
    
    weak var delegate : CompanySearchViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        // Set up camera button - button and barbuttonitem
        self.clearButton = UIButton(type: UIButtonType.Custom)
        self.clearButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        self.clearButton.setImage(UIImage(named: "cancel-50"), forState: UIControlState.Normal)
        self.clearButton.addTarget(self, action: "clearButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.clearBarButtonItem = UIBarButtonItem(customView: self.clearButton)
        self.clearBarButtonItem.style = UIBarButtonItemStyle.Plain
        self.navigationItem.rightBarButtonItem = self.clearBarButtonItem
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell.textLabel?.text = data["response"][indexPath.row]["company_name"].stringValue
        cell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        cell.detailTextLabel?.text = "\(data["response"][indexPath.row]["recruiter_count"].intValue)"
        cell.detailTextLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        API.editUserCompany(data["response"][indexPath.row]["id"].intValue) { (success, data) -> Void in
            if(success) {
                self.navigationController?.popViewControllerAnimated(true)
                self.delegate?.didFinishTask(self.data["response"][indexPath.row]["company_name"].stringValue)
            }
            else {
                self.presentViewController(Standard.generateAlert("Error", message: "Company could not be updated.", completion: {}), animated: true, completion: { () -> Void in
                    
                })
            }
        }

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data["response"].count
    }
    
    func clearButtonPressed(sender : UIButton) {
        API.editUserCompany(-1) { (success, data) -> Void in
            if(success) {
                self.navigationController?.popViewControllerAnimated(true)
                self.delegate?.didFinishTask("---")
            }
            else {
                self.presentViewController(Standard.generateAlert("Error", message: "Company could not be updated.", completion: {}), animated: true, completion: { () -> Void in
                    
                })
            }
            
        }

    }
    
}
