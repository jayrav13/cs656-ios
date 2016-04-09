//
//  SettingsViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/8/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class SettingsViewController: UITableViewController {
    
    /* Basic profile info */
    var nameCell : UITableViewCell = UITableViewCell()
    var emailCell : UITableViewCell = UITableViewCell()
    
    var nameTextField : UITextField = UITextField()
    var emailTextField : UITextField = UITextField()
    
    /* Social networks */
    var twitterCell : UITableViewCell = UITableViewCell()
    var linkedinCell : UITableViewCell = UITableViewCell()
    var resumeCell : UITableViewCell = UITableViewCell()
    var websiteCell : UITableViewCell = UITableViewCell()
    
    var twitterTextField : UITextField = UITextField()
    var linkedinTextField : UITextField = UITextField()
    var resumeTextField : UITextField = UITextField()
    var websiteTextField : UITextField = UITextField()
    
    /* Logout */
    var logoutCell : UITableViewCell = UITableViewCell()
    
    var data : JSON!
    
    var saveBarButtonItem : UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Settings"
        
        // construct first name cell, section 0, row 0
        self.nameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.nameTextField = UITextField(frame: CGRectInset(self.nameCell.contentView.bounds, 15, 0))
        self.nameTextField.placeholder = "Name"
        self.nameTextField.text = self.data["response"]["name"].stringValue
        self.nameCell.addSubview(self.nameTextField)
        
        // construct first name cell, section 0, row 1
        self.emailCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.emailTextField = UITextField(frame: CGRectInset(self.emailCell.contentView.bounds, 15, 0))
        self.emailTextField.placeholder = "Email"
        self.emailTextField.text = self.data["response"]["email"].stringValue
        self.emailCell.addSubview(self.emailTextField)
        
        // construct first name cell, section 1, row 0
        self.twitterCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.twitterTextField = UITextField(frame: CGRectInset(self.twitterCell.contentView.bounds, 15, 0))
        self.twitterTextField.placeholder = "Twitter"
        self.twitterTextField.text = self.data["response"]["twitter"].stringValue
        self.twitterCell.addSubview(self.twitterTextField)
        
        // construct first name cell, section 1, row 0
        self.linkedinCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.linkedinTextField = UITextField(frame: CGRectInset(self.linkedinCell.contentView.bounds, 15, 0))
        self.linkedinTextField.placeholder = "LinkedIn"
        self.linkedinTextField.text = self.data["response"]["linkedin"].stringValue
        self.linkedinCell.addSubview(self.linkedinTextField)
        
        // construct first name cell, section 1, row 0
        self.resumeCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.resumeTextField = UITextField(frame: CGRectInset(self.resumeCell.contentView.bounds, 15, 0))
        self.resumeTextField.placeholder = "Resume"
        self.resumeTextField.text = self.data["response"]["resume"].stringValue
        self.resumeCell.addSubview(self.resumeTextField)
        
        // construct first name cell, section 1, row 0
        self.websiteCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.websiteTextField = UITextField(frame: CGRectInset(self.websiteCell.contentView.bounds, 15, 0))
        self.websiteTextField.placeholder = "Website"
        self.websiteTextField.text = self.data["response"]["website"].stringValue
        self.websiteCell.addSubview(self.websiteTextField)

        self.logoutCell.textLabel?.text = "Log Out"
        
        self.data = []
        
        self.saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveButtonPressed:")
        self.navigationItem.rightBarButtonItem = self.saveBarButtonItem

    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        case 1: return 4    // section 1 has 1 row
        case 2: return 1
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.nameCell   // section 0, row 0 is the first name
            case 1: return self.emailCell    // section 0, row 1 is the last name
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
            case 0: return self.twitterCell       // section 1, row 0 is the twitter option
            case 1: return self.linkedinCell     // section 1, row 1 is the linkedin option
            case 2: return self.resumeCell      // section 1, row 2 is the resume option
            case 3: return self.websiteCell    // section 1, row 3 is the website option
            default: fatalError("Unknown row in section 1")
            }
        case 2:
            switch(indexPath.row) {
            case 0: return self.logoutCell
            default: fatalError("Unknown row in section 2")
            }
        default: fatalError("Unknown section")
        }
    }

    // Customize the section headings for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Profile"
        case 1: return "Social"
        case 2: return "Admin"
        default: fatalError("Unknown section")
        }
    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section == 2 && indexPath.row == 0) {
            // logout
            API.logoutUser({ (success, data) -> Void in
                if(success) {
                    LocalAPI.removeUserToken()
                    self.view.window?.rootViewController = UINavigationController(rootViewController: UserManagementController())
                }
            })
            print("Logout")
        }
        
    }
    
    func saveButtonPressed(sender: UIButton) {
        
    }
    
}
