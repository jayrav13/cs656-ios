//
//  ScanQRCodeViewController.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 4/10/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftQRCode

protocol ScanQRCodeViewControllerDelegate : class {
    func didConnectUser(success : Bool, name : String)
}

class ScanQRCodeViewController : UIViewController {
    
    var scanner : QRCode!
    var delegate : ScanQRCodeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.scanner = QRCode()
        scanner.prepareScan(self.view) { (stringValue) in
            print(stringValue)
            API.addConnection(stringValue, completion: { (success, data) in
                
                if(success) {
                    self.presentViewController(Standard.generateAlert("Success", message: "You're now connected with \(data["users"]["scannee"]["name"].stringValue)", completion: { 
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }), animated: true, completion: { 
                        
                    })
                }
                else {
                    self.presentViewController(Standard.generateAlert("Error", message: data["message"].stringValue, completion: {
                        
                        self.navigationController?.popViewControllerAnimated(true)
                        
                    }), animated: true, completion: {
                        
                    })
                    
                }
            })
            
        }
        scanner.scanFrame = self.view.bounds
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scanner.startScan()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}