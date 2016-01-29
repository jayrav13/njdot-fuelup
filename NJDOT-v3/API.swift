//
//  API.swift
//  NJDOT-v3
//
//  Created by Jay Ravaliya on 1/29/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class API {
    
    static let baseURL = "http://52.32.244.255/"
    
    static func getStations(latitude : CLLocationDegrees, longitude : CLLocationDegrees, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "latitude" : latitude,
            "longitude" : longitude
        ]
        
        Alamofire.request(Method.GET, baseURL + "stations", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in

            if response.response?.statusCode == 200 {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func getBridges(latitude : CLLocationDegrees, longitude : CLLocationDegrees, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "latitude" : latitude,
            "longitude" : longitude
        ]
        
        Alamofire.request(Method.GET, baseURL + "bridges", parameters: parameters, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response) -> Void in
            
            if response.response?.statusCode == 200 {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                print(response.response?.statusCode)
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
}

class Standard {
    
    static let screenHeight = UIScreen.mainScreen().bounds.height
    static let screenWidth = UIScreen.mainScreen().bounds.width
    
}