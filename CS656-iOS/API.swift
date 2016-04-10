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
    // Register
    static func registerUser(name: String, email: String, password: String, completion : (success: Bool, data: JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "name" : name,
            "email" : email,
            "password" : password,
        ]        
        
        Alamofire.request(Method.POST, baseURL + "/user/register", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    // Login
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
    
    // Get
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
    
    static func editUser(name : String, email : String, twitter : String, linkedin : String, resume : String, website : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "name" : name,
            "email" : email,
            "twitter" : twitter,
            "linkedin" : linkedin,
            "resume" : resume,
            "website" : website,
            
            "token" : LocalAPI.getUserToken()
        ]
        
        Alamofire.request(Method.PUT, baseURL + "/user/edit", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    static func editUserCompany(company_id : Int, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject]? = [
            "token" : LocalAPI.getUserToken(),
            "company_id" : company_id
        ]
        
        Alamofire.request(Method.PUT, baseURL + "/user/edit", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    // Logout
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
    
    /* 
     *  Relationship Management 
     */
    static func addConnection(connection_token : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "token" : LocalAPI.getUserToken(),
            "connection_token" : connection_token
        ]
        
        Alamofire.request(Method.POST, baseURL + "/relationship/add", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) in
            
            if(response.response?.statusCode == 200) {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                // return message to display error
                completion(success: false, data: JSON(response.result.value!))
            }
            
        }
        
    }
    
    /*
     *  Companies
     */
    static func companiesSearch(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "token" : LocalAPI.getUserToken()
        ]
        
        Alamofire.request(Method.GET, baseURL + "/company/search", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
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