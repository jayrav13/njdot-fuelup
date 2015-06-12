//
//  StationsMapViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/12/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit
import MapKit

var map : MKMapView!

class StationsMapViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        map = MKMapView(frame: view.frame)
        view.addSubview(map)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
