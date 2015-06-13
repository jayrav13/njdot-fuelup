//
//  StationsMapViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/12/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit
import MapKit

class StationsMapViewController: UIViewController, MKMapViewDelegate {
    
    // set up map variable, array of all pins
    var map : MKMapView!
    var pins : [MKPointAnnotation] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set up map to fill up the entire frame
        map = MKMapView(frame: view.frame)

        // center will be the approximate center of NJ, which is 40.3140, -74.5089. region will have a lat and lon delta of 2 deg
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.3140, longitude: -74.5089)
        var region : MKCoordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        map.setRegion(region, animated: true)
        
        // set map type to hybrid, add to view
        map.mapType = MKMapType.Hybrid
        view.addSubview(map)
        
        // for each station...
        for var x = 0; x < allStations.count; x++
        {
            // append a new MKPointAnnotation to array
            pins.append(MKPointAnnotation())

            // location set from lat and long, add the coordinate to the array, set the title and add to map
            var loc = CLLocationCoordinate2D(latitude: CLLocationDegrees(allStations[x]["stationLat"]!.doubleValue), longitude: CLLocationDegrees(allStations[x]["stationLon"]!.doubleValue))
            pins[x].coordinate = loc
            pins[x].title = (allStations[x]["stationName"] as? String)!
            map.addAnnotation(pins[x])
        }
        
        // add a reset button to zoom back out to all of NJ
        var resetZoom : UIBarButtonItem = UIBarButtonItem(title: "Reset", style: UIBarButtonItemStyle.Plain, target: self, action: "resetZoom:")
        self.navigationItem.rightBarButtonItem = resetZoom
        
        // set title
        self.title = "All Stations"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // zooms back out
    func resetZoom(sender: UIButton!)
    {
        // center will be the approximate center of NJ, which is 40.3140, -74.5089. region will have a lat and lon delta of 2 deg
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 40.3140, longitude: -74.5089)
        var region : MKCoordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2))
        map.setRegion(region, animated: true)
    }
    
}
