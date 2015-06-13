//
//  StationsDetailViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/12/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit
import MapKit

class StationsDetailViewController: UIViewController, MKMapViewDelegate {
    
    var map : MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = (allStations[stationId]["stationName"] as? String)!
        
        map = MKMapView()
        map.frame = CGRectMake(0, 0, screenWidth, screenHeight/2)
        view.addSubview(map)
        
        println((allStations[stationId]["stationName"] as? String)!)
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
