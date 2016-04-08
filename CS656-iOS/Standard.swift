//
//  Standard.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 2/7/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import UIKit

class Standard {
    
    static let screenWidth = UIScreen.mainScreen().bounds.width
    static let screenHeight = UIScreen.mainScreen().bounds.height
    
    static func generateAlert(title : String, message : String) -> UIAlertController {
        
        let alert : UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (action) -> Void in
            
            
            
        }))
        
        return alert
        
    }
    
}
