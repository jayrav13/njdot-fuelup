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
    
    // create map and pin
    var map : MKMapView!
    var pin : MKPointAnnotation!
    
    // address and distance label
    var address : UILabel!
    var cityCounty : UILabel!
    var distance : UILabel!
    
    // hours and type label
    var hoursLabel : UILabel!
    var hours : UILabel!
    var typeLabel : UILabel!
    var type : UILabel!
    
    // button
    var button : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set title equal to the stationName
        self.title = (allStations[stationId]["stationName"] as? String)!
        
        // create map, add it to the view
        map = MKMapView()
        map.frame = CGRectMake(0, 0, screenWidth, screenHeight/2)
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (allStations[stationId]["stationLat"] as? Double)!, longitude: (allStations[stationId]["stationLon"] as? Double)!)
        var region : MKCoordinateRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
        map.setRegion(region, animated: true)
        map.mapType = MKMapType.Hybrid
        view.addSubview(map)
        
        // create pin, add it to the map
        pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake((allStations[stationId]["stationLat"] as? Double)!, (allStations[stationId]["stationLon"] as? Double)!)
        map.addAnnotation(pin)
        
        // set background color to white
        view.backgroundColor = UIColor.whiteColor()
        
        // set up all labels
        address = UILabel()
        cityCounty = UILabel()
        distance = UILabel()
        hours = UILabel()
        type = UILabel()
        hoursLabel = UILabel()
        typeLabel = UILabel()
        button = UIButton.buttonWithType(UIButtonType.System) as! UIButton
    
        address.text = (allStations[stationId]["stationAddress"] as? String)!
        cityCounty.text = (allStations[stationId]["stationCity"] as? String)! + ", " + (allStations[stationId]["stationCounty"] as? String)! + ", NJ"
        distance.text = "Distance: " + String(stringInterpolationSegment: Double(Int(sortedStations[sortedId]["distance"]!!.doubleValue * 100))/100) + " mi"
        hours.text = (allStations[stationId]["stationHours"] as? String)!
        type.text = (allStations[stationId]["stationTypeGas"] as? String)!
        hoursLabel.text = "Hours: "
        typeLabel.text = "Fuel Type: "
        button.setTitle("Open Menu", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonMenu:", forControlEvents: UIControlEvents.TouchUpInside)
    
        address.frame = CGRectMake(0, screenHeight/2, screenWidth, 50)
        address.adjustsFontSizeToFitWidth = true
        address.textAlignment = NSTextAlignment.Center
        address.font = UIFont(name: "Raleway-Light", size: 20)
        
        cityCounty.frame = CGRectMake(0, screenHeight/2 + 25, screenWidth, 50)
        cityCounty.adjustsFontSizeToFitWidth = true
        cityCounty.textAlignment = NSTextAlignment.Center
        cityCounty.font = UIFont(name: "Raleway-Light", size: 20)
        
        distance.frame = CGRectMake(0, screenHeight/2 + 50, screenWidth, 50)
        distance.adjustsFontSizeToFitWidth = true
        distance.textAlignment = NSTextAlignment.Center
        distance.font = UIFont(name: "Raleway-Light", size: 16)
        
        hoursLabel.frame = CGRectMake(screenWidth/2 - 100, screenHeight/2 + 100, 100, 50)
        hoursLabel.textAlignment = NSTextAlignment.Left
        hoursLabel.font = UIFont(name: "Raleway-Bold", size: 16)
        
        hours.frame = CGRectMake(screenWidth/2, screenHeight/2 + 100, screenWidth/2, 50)
        hours.adjustsFontSizeToFitWidth = true
        hours.textAlignment = NSTextAlignment.Left
        hours.font = UIFont(name: "Raleway-Light", size: 16)
        
        typeLabel.frame = CGRectMake(screenWidth/2 - 100, screenHeight/2 + 125, 100, 50)
        typeLabel.textAlignment = NSTextAlignment.Left
        typeLabel.font = UIFont(name: "Raleway-Bold", size: 16)
        
        type.frame = CGRectMake(screenWidth/2, screenHeight/2 + 125, screenWidth/2, 50)
        type.adjustsFontSizeToFitWidth = true
        type.textAlignment = NSTextAlignment.Left
        type.font = UIFont(name: "Raleway-Light", size: 16)
        
        button.frame = CGRectMake(0, (3/4)*screenHeight - 25, screenWidth, (1/4)*screenHeight)
        button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 20)
        
        view.addSubview(address)
        view.addSubview(cityCounty)
        view.addSubview(distance)
        view.addSubview(hours)
        view.addSubview(hoursLabel)
        view.addSubview(type)
        view.addSubview(typeLabel)
        view.addSubview(button)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func buttonMenu(sender: UIButton!)
    {
        var actionSheet = UIAlertController(title: "Station Menu", message: "Select an Option", preferredStyle: UIAlertControllerStyle.ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Navigate", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            println("Navigate pressed")
        }))
        actionSheet.addAction(UIAlertAction(title: "Call", style: UIAlertActionStyle.Default, handler: { (alert: UIAlertAction!) -> Void in
            println("Call pressed")
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (alert: UIAlertAction!) -> Void in
            println("Cancel pressed")
        }))
        self.presentViewController(actionSheet, animated: true) { () -> Void in
            println("Action sheet opened")
        }
    }
    
}
