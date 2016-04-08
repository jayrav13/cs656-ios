//
//  UserManagementController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/4/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import TextFieldEffects

class UserManagementController : UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    /*
     *  Scroll View
     */
    var scrollView : UIScrollView!
    var scrollViewGestureRecognizer : UITapGestureRecognizer!
    var pageControl : UIPageControl!

    /*
     *  Login
     */
    // Text Fields
    var loginEmailTextField : KaedeTextField!
    var loginPasswordTextField : KaedeTextField!
    
    // Buttons
    var loginLoginButton : UIButton!
    var loginRegisterButton : UIButton!
    
    /*
     *  Register
     */
    var registerNameTextField : KaedeTextField!
    var registerEmailTextField : KaedeTextField!
    var registerPasswordTextField : KaedeTextField!
    
    var registerRegisterButton : UIButton!
    var registerLoginButton : UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Login"
        self.view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 244/255, alpha: 1)
        self.view.userInteractionEnabled = true
        
        self.scrollView = UIScrollView()
        self.scrollView.frame = self.view.frame
        self.scrollView.contentSize.width = Standard.screenWidth * 2
        self.scrollView.userInteractionEnabled = true
        self.scrollView.delegate = self
        self.scrollView.delaysContentTouches = false
        self.scrollView.scrollEnabled = false
        self.view.addSubview(self.scrollView)
        
        self.loginEmailTextField = KaedeTextField()
        self.loginEmailTextField.placeholder = "Email"
        self.loginEmailTextField.placeholderFontScale = CGFloat(1)
        self.loginEmailTextField.frame = CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.1, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.075)
        self.loginEmailTextField.layer.cornerRadius = 5
        self.loginEmailTextField.placeholderColor = UIColor.whiteColor()
        self.loginEmailTextField.foregroundColor = UIColor(red: 18/255, green: 68/255, blue: 187/255, alpha: 1)
        self.loginEmailTextField.backgroundColor = UIColor(red: 147/255, green: 201/255, blue: 254/255, alpha: 1)
        self.loginEmailTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.loginEmailTextField.autocorrectionType = UITextAutocorrectionType.No
        self.scrollView.addSubview(self.loginEmailTextField)
        
        self.loginPasswordTextField = KaedeTextField()
        self.loginPasswordTextField.placeholder = "Password"
        self.loginPasswordTextField.placeholderColor = UIColor.whiteColor()
        self.loginPasswordTextField.foregroundColor = UIColor(red: 18/255, green: 68/255, blue: 187/255, alpha: 1)
        self.loginPasswordTextField.backgroundColor = UIColor(red: 147/255, green: 201/255, blue: 254/255, alpha: 1)
        self.loginPasswordTextField.placeholderFontScale = CGFloat(1)
        self.loginPasswordTextField.frame = CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.075)
        self.loginPasswordTextField.layer.cornerRadius = 5
        self.loginPasswordTextField.secureTextEntry = true
        self.scrollView.addSubview(self.loginPasswordTextField)
        
        self.loginLoginButton = UIButton(type: UIButtonType.System)
        self.loginLoginButton.frame = CGRect(x: Standard.screenWidth * 0.25, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.25, height: Standard.screenHeight * 0.1)
        self.loginLoginButton.userInteractionEnabled = true
        self.loginLoginButton.setTitle("Login", forState: UIControlState.Normal)
        self.loginLoginButton.titleLabel?.textAlignment = NSTextAlignment.Center
        self.loginLoginButton.addTarget(self, action: "loginLoginButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.loginLoginButton)
        
        self.loginRegisterButton = UIButton(type: UIButtonType.System)
        self.loginRegisterButton.frame = CGRect(x: Standard.screenWidth * 0.5, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.25, height: Standard.screenHeight * 0.1)
        self.loginRegisterButton.userInteractionEnabled = true
        self.loginRegisterButton.setTitle("Register", forState: UIControlState.Normal)
        self.loginRegisterButton.titleLabel?.textAlignment = NSTextAlignment.Center
        self.loginRegisterButton.addTarget(self, action: "loginRegisterButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.loginRegisterButton)
        
        self.scrollViewGestureRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewTapped:")
        self.scrollViewGestureRecognizer.delegate = self
        self.scrollView.addGestureRecognizer(self.scrollViewGestureRecognizer)
        
        self.registerNameTextField = KaedeTextField()
        self.registerNameTextField.placeholder = "Name"
        self.registerNameTextField.placeholderFontScale = CGFloat(1)
        self.registerNameTextField.frame = CGRect(x: Standard.screenWidth * 1.1, y: Standard.screenHeight * 0.1, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.075)
        self.registerNameTextField.layer.cornerRadius = 5
        self.registerNameTextField.placeholderColor = UIColor.whiteColor()
        self.registerNameTextField.foregroundColor = UIColor(red: 18/255, green: 68/255, blue: 187/255, alpha: 1)
        self.registerNameTextField.backgroundColor = UIColor(red: 147/255, green: 201/255, blue: 254/255, alpha: 1)
        self.registerNameTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.registerNameTextField.autocorrectionType = UITextAutocorrectionType.No
        self.scrollView.addSubview(self.registerNameTextField)
        
        self.registerEmailTextField = KaedeTextField()
        self.registerEmailTextField.placeholder = "Email"
        self.registerEmailTextField.placeholderFontScale = CGFloat(1)
        self.registerEmailTextField.frame = CGRect(x: Standard.screenWidth * 1.1, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.075)
        self.registerEmailTextField.layer.cornerRadius = 5
        self.registerEmailTextField.placeholderColor = UIColor.whiteColor()
        self.registerEmailTextField.foregroundColor = UIColor(red: 18/255, green: 68/255, blue: 187/255, alpha: 1)
        self.registerEmailTextField.backgroundColor = UIColor(red: 147/255, green: 201/255, blue: 254/255, alpha: 1)
        self.registerEmailTextField.autocapitalizationType = UITextAutocapitalizationType.None
        self.registerEmailTextField.autocorrectionType = UITextAutocorrectionType.No
        self.scrollView.addSubview(self.registerEmailTextField)
        
        self.registerPasswordTextField = KaedeTextField()
        self.registerPasswordTextField.placeholder = "Password"
        self.registerPasswordTextField.placeholderColor = UIColor.whiteColor()
        self.registerPasswordTextField.foregroundColor = UIColor(red: 18/255, green: 68/255, blue: 187/255, alpha: 1)
        self.registerPasswordTextField.backgroundColor = UIColor(red: 147/255, green: 201/255, blue: 254/255, alpha: 1)
        self.registerPasswordTextField.placeholderFontScale = CGFloat(1)
        self.registerPasswordTextField.frame = CGRect(x: Standard.screenWidth * 1.1, y: Standard.screenHeight * 0.3, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.075)
        self.registerPasswordTextField.layer.cornerRadius = 5
        self.scrollView.addSubview(self.registerPasswordTextField)
        
        self.registerRegisterButton = UIButton(type: UIButtonType.System)
        self.registerRegisterButton.frame = CGRect(x: Standard.screenWidth * 1.25, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.25, height: Standard.screenHeight * 0.1)
        self.registerRegisterButton.userInteractionEnabled = true
        self.registerRegisterButton.setTitle("Register", forState: UIControlState.Normal)
        self.registerRegisterButton.titleLabel?.textAlignment = NSTextAlignment.Center
        self.registerRegisterButton.addTarget(self, action: "loginLoginButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.registerRegisterButton)
        
        self.registerLoginButton = UIButton(type: UIButtonType.System)
        self.registerLoginButton.frame = CGRect(x: Standard.screenWidth * 1.5, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.25, height: Standard.screenHeight * 0.1)
        self.registerLoginButton.userInteractionEnabled = true
        self.registerLoginButton.setTitle("Login", forState: UIControlState.Normal)
        self.registerLoginButton.titleLabel?.textAlignment = NSTextAlignment.Center
        self.registerLoginButton.addTarget(self, action: "registerRegisterButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.scrollView.addSubview(self.registerLoginButton)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewTapped(sender : UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.scrollView.endEditing(true)
    }
    
    func loginLoginButtonPressed(sender : UIButton) {
        
        API.loginUser(self.loginEmailTextField.text!, password: self.loginPasswordTextField.text!) { (success, data) -> Void in
            if(success) {
                print(data)
                LocalAPI.setUserToken(data["message"]["token"].stringValue)
                self.view.window?.rootViewController = UINavigationController(rootViewController: ConnectionsListViewController())
            }
            else {
                self.presentViewController(Standard.generateAlert("Error", message: "Login failed - please try again!"), animated: true, completion: { () -> Void in
                    
                })
            }
        }
        
    }
    
    func registerRegisterButtonPressed(sender : UIButton) {
        
        API.registerUser(self.registerNameTextField.text!, email: self.registerEmailTextField.text!, password: self.registerPasswordTextField.text!) { (success, data) -> Void in
            if(success) {
                
            }
            else {
                self.presentViewController(Standard.generateAlert("Error", message: "Registration failed - please try again!"), animated: true, completion: { () -> Void in
                    
                })
            }
        }
        
    }
    
    func loginRegisterButtonPressed(sender : UIButton) {
        // Scroll to the position that takes into account height with navbar and status bar there
        self.scrollView.setContentOffset(CGPoint(x: Standard.screenWidth, y: -1 * ((self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.size.height)), animated: true)
    }
    
    func registerLoginButtonPressed(sender : UIButton) {
        // Scroll to the position that takes into account height with navbar and status bar there
        self.scrollView.setContentOffset(CGPoint(x: 0, y: -1 * ((self.navigationController?.navigationBar.frame.height)! + UIApplication.sharedApplication().statusBarFrame.size.height)), animated: true)
    }
    
}