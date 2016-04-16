//
//  SkillsViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SkillsViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var data : JSON!
    var function : Int!
    var addValueBarButtonItem : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        self.addValueBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonPressed:")
        self.navigationItem.rightBarButtonItem = self.addValueBarButtonItem
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data["response"].count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.textLabel?.text = data["response"][indexPath.row][0].stringValue
        return cell
    }
    
    func addButtonPressed(sender : UIButton) {
        
        let alertController : UIAlertController = UIAlertController(title: "Add Skill", message: "Add a new skill here!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            
        }
        
        alertController.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.Default, handler: { (alertAction) in

            let textField = alertController.textFields![0] as UITextField
            
            switch(self.function) {
            case 1:
                API.addPrimarySkill(textField.text!, completion: { (success, data) in
                    if(success) {
                        API.getPrimarySkills({ (success, data) in
                            if(success) {
                                self.data = data
                                self.tableView.reloadData()
                                self.presentViewController(Standard.generateAlert("Success", message: "Skill added!", completion: {
                                    
                                }), animated: true, completion: { 
                                    
                                })
                                
                            }
                            else {
                                self.presentViewController(Standard.generateAlert("Error", message: "Something went wrong. Please try again.", completion: {
                                    
                                }), animated: true, completion: {
                                    
                                })
                            }
                        })
                    }
                    else {
                        self.presentViewController(Standard.generateAlert("Error", message: "Something went wrong. Please try again.", completion: {
                            
                        }), animated: true, completion: {
                            
                        })
                    }
                })
            case 2:
                API.addSecondarySkill(textField.text!, completion: { (success, data) in
                    if(success) {
                        API.getSecondarySkills({ (success, data) in
                            if(success) {
                                self.data = data
                                self.tableView.reloadData()
                                self.presentViewController(Standard.generateAlert("Success", message: "Skill added!", completion: {
                                    
                                }), animated: true, completion: { 
                                    
                                })
                                
                            }
                            else {
                                self.presentViewController(Standard.generateAlert("Error", message: "Something went wrong. Please try again.", completion: {
                                    
                                }), animated: true, completion: { 
                                    
                                })
                            }
                        })
                    }
                    else {
                        self.presentViewController(Standard.generateAlert("Error", message: "Something went wrong. Please try again.", completion: {
                            
                        }), animated: true, completion: {
                            
                        })
                    }
                })
            case 3:
                API.addPlatformSkill(textField.text!, completion: { (success, data) in
                    if(success) {
                        API.getPlatforms({ (success, data) in
                            if(success) {
                                self.data = data
                                self.tableView.reloadData()
                                self.presentViewController(Standard.generateAlert("Success", message: "Skill added!", completion: { 
                                    
                                }), animated: true, completion: { 
                                    
                                })
                            }
                            else {
                                self.presentViewController(Standard.generateAlert("Error", message: "Something went wrong. Please try again.", completion: {
                                    
                                }), animated: true, completion: {
                                    
                                })
                            }
                        })
                    }
                    else {
                        self.presentViewController(Standard.generateAlert("Error", message: "Something went wrong. Please try again.", completion: {
                            
                        }), animated: true, completion: {
                            
                        })
                    }
                })
            default:
                print("Throw Error")
            }
            
            

        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (alertAction) in
        }))
        
        self.presentViewController(alertController, animated: true) {
            
        }
        
    }
    
}
