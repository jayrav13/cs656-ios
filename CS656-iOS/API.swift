//
//  API.swift
//  CS656-iOS
//
//  Created by Jay Ravaliya on 2/7/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import SwiftyJSON
import Alamofire

/*
 *  API Notes
 *  1) All requests should have data encoded in URL instead of JSON.
 */

class API {

    static let baseURL : String = "http://52.36.159.253/api/v0.1"
    
    /*
     *  Heartbeat
     */
    static func heartbeat(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        Alamofire.request(Method.GET, baseURL + "/heartbeat").responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    /*
     *  User Management Controller
     */
    static func registerUser(name: String, email: String, password: String, completion : (success: Bool, data: JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "name" : name,
            "email" : email,
            "password" : password,
        ]        
        
        Alamofire.request(Method.POST, baseURL + "/user/login", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    static func loginUser(email: String, password: String, completion: (success: Bool, data: JSON) -> Void) -> Void {
        
        let parameters: [String : AnyObject] = [
            "email" : email,
            "password" : password
        ]
        
        Alamofire.request(Method.POST, baseURL + "/user/login", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    static func getUser(completion : (success: Bool, data: JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "token" : LocalAPI.getUserToken()
        ]
        
        Alamofire.request(Method.GET, baseURL + "/user/get", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func logoutUser(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "token" : LocalAPI.getUserToken()
        ]
        
        Alamofire.request(Method.POST, baseURL + "/user/logout", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func relationshipList(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "token" : LocalAPI.getUserToken()
        ]
        
        Alamofire.request(Method.GET, baseURL + "/relationship/list", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
}