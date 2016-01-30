//
//  MapViewController.swift
//  NJDOT-v3
//
//  Created by Jay Ravaliya on 1/29/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import SwiftyJSON
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
    var mapView : MKMapView!
    var latitude : CLLocationDegrees!
    var longitude : CLLocationDegrees!
    
    var dataType : String!
    var data : JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView = MKMapView()
        self.mapView.frame = self.view.frame
        self.mapView.mapType = MKMapType.Standard
        self.mapView.zoomEnabled = true
        self.mapView.scrollEnabled = true
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.view.addSubview(self.mapView)
        
        for(var i = 0; i < data.count; i++) {
            let pin = MKPointAnnotation()
            if(dataType == "stations") {
                pin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.data[i]["stationLatitude"].doubleValue), longitude: CLLocationDegrees(self.data[i]["stationLongitude"].doubleValue))
                pin.title = self.data[i]["stationName"].stringValue
            }
            else {
                pin.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.data[i]["bridgeLatitude"].doubleValue), longitude: CLLocationDegrees(self.data[i]["bridgeLongitude"].doubleValue))
                pin.title = self.data[i]["bridgeName"].stringValue
            }
            self.mapView.addAnnotation(pin)
            
        }
        
        let coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        self.mapView.setRegion(coordinateRegion, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}