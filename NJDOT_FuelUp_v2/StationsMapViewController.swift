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

        var center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.3140, longitude: -74.5089)
        var region : MKCoordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        map.setRegion(region, animated: true)
        map.mapType = MKMapType.Hybrid
        
        view.addSubview(map)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
