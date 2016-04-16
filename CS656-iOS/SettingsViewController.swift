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
import TextFieldEffects

class SettingsViewController: UITableViewController, CompanySearchViewControllerDelegate {
    
    /* Basic profile info */
    var nameCell : UITableViewCell!
    var emailCell : UITableViewCell!
    
    var nameTextField : KaedeTextField!
    var emailTextField : KaedeTextField!
    
    /* Social networks */
    var twitterCell : UITableViewCell!
    var linkedinCell : UITableViewCell!
    var resumeCell : UITableViewCell!
    var websiteCell : UITableViewCell!
    
    var twitterTextField : KaedeTextField!
    var linkedinTextField : KaedeTextField!
    var resumeTextField : KaedeTextField!
    var websiteTextField : KaedeTextField!
    
    /* Companies */
    var companiesCell : UITableViewCell!
    
    /* Skills */
    var skillsCell : UITableViewCell!
    
    /* View Profile */
    var profileCell : UITableViewCell!
    
    /* Logout */
    var logoutCell : UITableViewCell!
    
    var data : JSON!
    
    var saveBarButtonItem : UIBarButtonItem!
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Settings"
        
        // construct first name cell, section 0, row 0
        self.nameCell = UITableViewCell()
        self.nameCell.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 44)
        self.nameCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.nameTextField = KaedeTextField(frame: self.nameCell.frame)
        self.nameTextField.placeholder = "Name"
        self.nameTextField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.nameTextField.text = self.data["response"]["name"].stringValue
        self.nameTextField.foregroundColor = UIColor.lightGrayColor()
        self.nameTextField.autocorrectionType = UITextAutocorrectionType.No
        self.nameCell.addSubview(self.nameTextField)
        
        // construct first name cell, section 0, row 1
        self.emailCell = UITableViewCell()
        self.emailCell.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 44)
        self.emailCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.emailTextField = KaedeTextField(frame: self.nameCell.frame)
        self.emailTextField.placeholder = "Email"
        self.emailTextField.foregroundColor = UIColor.lightGrayColor()
        self.emailTextField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.emailTextField.text = self.data["response"]["email"].stringValue
        self.emailTextField.autocorrectionType = UITextAutocorrectionType.No
        self.emailTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.emailTextField.keyboardType = UIKeyboardType.EmailAddress
        self.emailCell.addSubview(self.emailTextField)
        
        // construct first name cell, section 1, row 0
        self.twitterCell = UITableViewCell()
        self.twitterCell.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 44)
        self.twitterCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.twitterTextField = KaedeTextField(frame: self.nameCell.frame)
        self.twitterTextField.placeholder = "@{handle}"
        self.twitterTextField.foregroundColor = UIColor.lightGrayColor()
        self.twitterTextField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.twitterTextField.text = self.data["response"]["twitter"].stringValue
        self.twitterTextField.autocorrectionType = UITextAutocorrectionType.No
        self.twitterTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.twitterCell.addSubview(self.twitterTextField)
        
        // construct first name cell, section 1, row 0
        self.linkedinCell = UITableViewCell()
        self.linkedinCell.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 44)
        self.linkedinCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.linkedinTextField = KaedeTextField(frame: self.nameCell.frame)
        self.linkedinTextField.placeholder = "/in/{username}"
        self.linkedinTextField.foregroundColor = UIColor.lightGrayColor()
        self.linkedinTextField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.linkedinTextField.text = self.data["response"]["linkedin"].stringValue
        self.linkedinTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.linkedinTextField.autocorrectionType = UITextAutocorrectionType.No
        self.linkedinCell.addSubview(self.linkedinTextField)
        
        // construct first name cell, section 1, row 0
        self.resumeCell = UITableViewCell()
        self.resumeCell.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 44)
        self.resumeCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.resumeTextField = KaedeTextField(frame: self.nameCell.frame)
        self.resumeTextField.placeholder = "Resume URL"
        self.resumeTextField.foregroundColor = UIColor.lightGrayColor()
        self.resumeTextField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.resumeTextField.text = self.data["response"]["resume"].stringValue
        self.resumeTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.resumeTextField.autocorrectionType = UITextAutocorrectionType.No
        self.resumeTextField.keyboardType = UIKeyboardType.URL
        self.resumeCell.addSubview(self.resumeTextField)
        
        // construct first name cell, section 1, row 0
        self.websiteCell = UITableViewCell()
        self.websiteCell.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: 44)
        self.websiteCell.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        self.websiteTextField = KaedeTextField(frame: self.nameCell.frame)
        self.websiteTextField.placeholder = "Website URL"
        self.websiteTextField.foregroundColor = UIColor.lightGrayColor()
        self.websiteTextField.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.websiteTextField.text = self.data["response"]["website"].stringValue
        self.websiteTextField.autocorrectionType = UITextAutocorrectionType.No
        self.websiteTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.websiteTextField.keyboardType = UIKeyboardType.URL
        self.websiteCell.addSubview(self.websiteTextField)
        
        // companies cell
        self.companiesCell = UITableViewCell()
        self.companiesCell.textLabel?.text = data["response"]["company"]["company_name"].stringValue.characters.count > 0 ? data["response"]["company"]["company_name"].stringValue : "---"
        self.companiesCell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.companiesCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.skillsCell = UITableViewCell()
        self.skillsCell.textLabel?.text = "Select Recruiter Skills"
        self.skillsCell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.skillsCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        //Admin
        self.profileCell = UITableViewCell()
        self.profileCell.textLabel?.text = "View Profile"
        self.profileCell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-Light", size: 20)
        self.profileCell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        self.logoutCell = UITableViewCell()
        self.logoutCell.textLabel?.text = "Log Out"
        self.logoutCell.backgroundColor = UIColor.redColor()
        self.logoutCell.textLabel?.textColor = UIColor.whiteColor()
        self.logoutCell.textLabel?.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
        self.logoutCell.textLabel?.textAlignment = NSTextAlignment.Center
        
        self.data = []
        
        self.saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save, target: self, action: "saveButtonPressed:")
        self.navigationItem.rightBarButtonItem = self.saveBarButtonItem
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return 2    // section 0 has 2 rows
        case 1: return 4    // section 1 has 1 row
        case 2: return (self.companiesCell.textLabel?.text == "---" ? 1 : 2)
        case 3: return 2
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
            case 0: return self.companiesCell
            case 1: return self.skillsCell
            default: fatalError("Unknown row in section 2")
            }
        case 3:
            switch(indexPath.row) {
            case 0: return self.profileCell
            case 1: return self.logoutCell
            default: fatalError("Unknown row in section 3")
            }
        default: fatalError("Unknown section")
        }
    }

    // Customize the section headings for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Profile"
        case 1: return "Social"
        case 2: return "Company"
        case 3: return "Admin"
        default: fatalError("Unknown section")
        }
    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(indexPath.section == 2 && indexPath.row == 0) {
            API.companiesSearch({ (success, data) -> Void in
                if(success) {
                    let csvc : CompanySearchViewController = CompanySearchViewController()
                    csvc.delegate = self
                    csvc.data = data
                    
                    self.navigationController?.pushViewController(csvc, animated: true)
                }
                else {
                    // Error
                }
            })
        }
        
        if(indexPath.section == 3 && indexPath.row == 0) {
            API.getUser({ (success, data) in
                if(success) {
                    let pvc : ProfileViewController = ProfileViewController()
                    pvc.data = data["response"]
                    self.navigationController?.pushViewController(pvc, animated: true)
                }
            })
            
        }
        
        if(indexPath.section == 3 && indexPath.row == 1) {
            // logout
            API.logoutUser({ (success, data) -> Void in
                if(success) {
                    LocalAPI.removeUserToken()
                    self.view.window?.rootViewController = UINavigationController(rootViewController: UserManagementController())
                }
            })
            print("Logout")
        }
        
        if(indexPath.section == 2 && indexPath.row == 1) {
            let qvc : QualificationViewController = QualificationViewController()
            self.navigationController?.pushViewController(qvc, animated: true)
        }
        
        
    }
    
    func saveButtonPressed(sender: UIButton) {
        API.editUser(self.nameTextField.text!, email: self.emailTextField.text!, twitter: self.twitterTextField.text!, linkedin: self.linkedinTextField.text!, resume: self.resumeTextField.text!, website: self.websiteTextField.text!) { (success, data) -> Void in
            
            if(success) {
                self.presentViewController(Standard.generateAlert("Success", message: "Profile edited successfully!", completion: {}), animated: true, completion: { () -> Void in
                    
                })
            }
            else {
                self.presentViewController(Standard.generateAlert("Error", message: "Unable to edit profile.", completion: {}), animated: true, completion: { () -> Void in
                    
                })
            }
            
        }
    }
    
    func didFinishTask(companyName : String) {
        self.presentViewController(Standard.generateAlert("Success", message: "Company updated!", completion: {}), animated: true, completion: { () -> Void in
            self.companiesCell.textLabel?.text = companyName
            self.tableView.reloadData()
        })
    }
    
}
