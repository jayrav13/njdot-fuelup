//
//  DistanceFormula.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/12/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import Darwin
import Foundation
import UIKit

// the sole purpose of this viewcontroller is to establish the below getDistanceFromLatLongInMiles formula

class DistanceFormula:UIViewController {
    
    func getDistanceFromLatLongInMiles(lat1: Double, lat2: Double, lon1: Double, lon2: Double) -> Double
    {
        var R: Double = 6371.0 // Radius of earth in KM
        var dLat = deg2rad(lat2 - lat1)
        var dLon = deg2rad(lon2 - lon1)
        var a = sin(dLat/2) * sin(dLat/2) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon/2) * sin(dLon/2)
        var c = atan2(sqrt(a), sqrt(1-a)) * 2
        
        return ((R * c) * 0.621371)
    }
    
    func deg2rad(deg: Double) -> Double
    {
        return deg * ((M_PI)/180)
    }
    
}
