//
//  QualificationsViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/14/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit

class QualificationViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if(indexPath.row == 0) {
            API.getPrimarySkills({ (success, data) in
                if(success) {
                    let svc : SkillsViewController = SkillsViewController()
                    svc.data = data
                    svc.title = "Primary Skills"
                    svc.function = 1
                    self.navigationController?.pushViewController(svc, animated: true)
                }
                else {
                    // Error
                    self.presentViewController(Standard.generateAlert("Error", message: "Unable to load primary skills.", completion: {
                        
                    }), animated: true, completion: {
                        
                    })
                }
            })
        }
        else if(indexPath.row == 1) {
            API.getSecondarySkills({ (success, data) in
                if(success) {
                    let svc : SkillsViewController = SkillsViewController()
                    svc.data = data
                    svc.title = "Secondary Skills"
                    svc.function = 2
                    self.navigationController?.pushViewController(svc, animated: true)
                }
                else {
                    // Error
                    self.presentViewController(Standard.generateAlert("Error", message: "Unable to load secondary skills.", completion: {
                        
                    }), animated: true, completion: {
                        
                    })
                }
            })
        }
        else if(indexPath.row == 2) {
            API.getPlatforms({ (success, data) in
                if(success) {
                    let svc : SkillsViewController = SkillsViewController()
                    svc.data = data
                    svc.title = "Platforms"
                    svc.function = 3
                    self.navigationController?.pushViewController(svc, animated: true)
                }
                else {
                    // Error
                    self.presentViewController(Standard.generateAlert("Error", message: "Unable to load secondary skills.", completion: {
                        
                    }), animated: true, completion: {
                        
                    })
                }
            })
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
        
        if(indexPath.row == 0) {
            cell.textLabel?.text = "Primary Skills"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else if(indexPath.row == 1) {
            cell.textLabel?.text = "Secondary Skills"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else if(indexPath.row == 2) {
            cell.textLabel?.text = "Platforms"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        else {
            // Other stuffs
        }
        
        return cell
    }
    
}
