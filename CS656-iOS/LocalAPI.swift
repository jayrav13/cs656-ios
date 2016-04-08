//
//  LocalAPI.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 3/31/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation

class LocalAPI {
    
    /* User Token */
    // Get Token
    static func getUserToken() -> String {
        return String(NSUserDefaults.standardUserDefaults().objectForKey("token")!)
    }
    
    // Set Token
    static func setUserToken(token : String) {
        NSUserDefaults.standardUserDefaults().setObject(token, forKey: "token")
    }
    
    // Check Token
    static func userTokenSet() -> Bool {
        return (NSUserDefaults.standardUserDefaults().objectForKey("token") != nil)
    }
    
    // Remove Token
    static func removeUserToken() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey("token")
    }
    
}