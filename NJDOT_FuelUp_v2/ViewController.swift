
//
//  ViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/10/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

// imports
import UIKit
import Parse
import Foundation
import CoreLocation

// establish variables for screen size
var screenWidth : CGFloat = 0.0
var screenHeight : CGFloat = 0.0

// fonts - set for user thorughout the app
var microFontRegular : UIFont = UIFont(name: "Raleway-Light", size: 30)!
var microFontBold : UIFont = UIFont(name: "Raleway-Bold", size: 30)!

// location manager - starts later in the app
var manager : CLLocationManager!

// all stations or bridges
// query objects
var allStations : [PFObject] = []
var allBridges : [PFObject] = []
// data structures for post-manipulation, used in other ViewControllers
var sortedStations : NSMutableArray = []
var bridgesArray : NSMutableArray = []

class ViewController: UIViewController, CLLocationManagerDelegate {

    // labels
    var mainLabel : UILabel!
    
    // buttons
    var stationsButton : UIButton!
    var bridgesButton : UIButton!
    
    // activity indicator
    var activityIndiciator : UIActivityIndicatorView!
    
    // create alert, establish variable for % value as query is running
    let alert: UIAlertController = UIAlertController(title: "Loading...", message: "0% Complete", preferredStyle: UIAlertControllerStyle.Alert)
    var value : Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calculate screen width and height for the entire screen, 
        // used throughout the app
        if screenWidth == 0.0 || screenHeight == 0.0
        {
            screenWidth = UIScreen.mainScreen().bounds.width
            screenHeight = UIScreen.mainScreen().bounds.height
        }
        
        // establish location
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // set background color to gray
        view.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
        
        // establish mainLabel
        mainLabel = UILabel()
        mainLabel.frame = CGRectMake(screenWidth/2 - 150, screenHeight/6 - 50, 300, 100)
        mainLabel.text = "NJ FUEL UP v2.0"
        mainLabel.textAlignment = NSTextAlignment.Center
        mainLabel.font = microFontBold
        view.addSubview(mainLabel)
        
        // establish Stations and Bridges buttons
        // stations button
        stationsButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        stationsButton.addTarget(self, action: "stationsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        stationsButton.frame = CGRectMake(screenWidth/2 - 100, screenHeight/2, 200, 75)
        stationsButton.setTitle("STATIONS", forState: UIControlState.Normal)
        stationsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        stationsButton.titleLabel!.font = microFontRegular
        stationsButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        stationsButton.backgroundColor = UIColor.blackColor()
        stationsButton.layer.cornerRadius = 5
        stationsButton.layer.borderWidth = 1
        stationsButton.layer.borderColor = UIColor.blackColor().CGColor
        
        // bridges button
        bridgesButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        bridgesButton.addTarget(self, action: "bridgesPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        bridgesButton.frame = CGRectMake(screenWidth/2 - 100, screenHeight/4 + 50, 200, 75)
        bridgesButton.setTitle("BRIDGES", forState: UIControlState.Normal)
        bridgesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        bridgesButton.titleLabel!.font = microFontRegular
        bridgesButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        bridgesButton.backgroundColor = UIColor.blackColor()
        bridgesButton.layer.cornerRadius = 5
        bridgesButton.layer.borderWidth = 1
        bridgesButton.layer.borderColor = UIColor.blackColor().CGColor
        
        // establish activity indicator
        activityIndiciator = UIActivityIndicatorView(frame: CGRectMake(screenWidth/2-10, screenHeight*(3/4), 20, 20))
        activityIndiciator.color = UIColor.blackColor()
        activityIndiciator.alpha = 0
        activityIndiciator.stopAnimating()
        
        // add buttons and activity indicator to view
        view.addSubview(stationsButton)
        view.addSubview(bridgesButton)
        view.addSubview(activityIndiciator)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // function warningMessage
    // purpose - display an alert message when requested
    func warningMessage(title : String, message : String)
    {
        let warning: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        warning.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { (action : UIAlertAction!) -> Void in
            println("Cancelled")
        }))
        self.presentViewController(warning, animated: true) { () -> Void in
            
        }
    }
    
    // present ViewController with sorted list of stations
    func stationsPressed(sender: UIButton!)
    {
        // if location authorization not set, print to logs
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse
        {
            warningMessage("Location Manager", message: "Be sure to give this app permission for Location Services in Settings!")
        }
        // else
        else
        {
            // show/animate activity indicator
            activityIndiciator.alpha = 1
            activityIndiciator.startAnimating()
            
            // if allStations haven't been pulled yet, query
            if allStations.count == 0
            {
                // establish query for all stations
                var query = PFQuery(className: "stations")
                
                // run query block
                query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
                    if error == nil
                    {
                        // as long as the data exists, set it equal to the allStations global variable
                        if let objects = objects as? [PFObject]
                        {
                            allStations = objects
                            
                            // set up an object to use to leverage the distance formula
                            let formula = DistanceFormula()
                            
                            // for each station, add it to the all stations array and sorted stations array
                            for var i = 0; i < allStations.count; i++
                            {
                                allStations[i]["stationDistance"] = formula.getDistanceFromLatLongInMiles(Double(manager.location.coordinate.latitude), lat2: allStations[i]["stationLat"]!.doubleValue, lon1: Double(manager.location.coordinate.longitude), lon2: allStations[i]["stationLon"]!.doubleValue)
                                
                                sortedStations.addObject(["id" : allStations[i]["id"]!.doubleValue, "distance" : allStations[i]["stationDistance"]!.doubleValue])
                                
                            }
                            
                            // sort stations
                            sortedStations.sortUsingComparator({ (obj1:AnyObject!, obj2:AnyObject!) -> NSComparisonResult in
                                var one = obj1["distance"]! as! Double
                                var two = obj2["distance"]! as! Double
                                if one > two
                                {
                                    return NSComparisonResult.OrderedDescending
                                }
                                else if two > one
                                {
                                    return NSComparisonResult.OrderedAscending
                                }
                                else
                                {
                                    return NSComparisonResult.OrderedSame
                                }
                            })
                            
                            // create a new navigation controller and push it onto the stack
                            self.pushToStationsTableViewController()
                        }
                        // if object is nil, something unexpected happened
                        else
                        {
                            println("Something happened!")
                        }
                    }
                    // print error if one exists
                    else
                    {
                        println(error)
                    }
                }
            }
            // otherwise, just go to navViewController - no need to query every time!
            else
            {
                self.pushToStationsTableViewController()
            }
        }

    }

    // present ViewController for user to input Bridge Id
    func bridgesPressed(sender: UIButton!)
    {
        
        // if location authorization not set, print to logs
        if CLLocationManager.authorizationStatus() != .AuthorizedWhenInUse
        {
            warningMessage("Location Manager", message: "Be sure to give this app permission for Location Services in Settings!")
        }
        else
        {
            var skip = 0
            var limit = 1000
            
            if bridgesArray.count == 0
            {
                self.presentViewController(alert, animated: true) { () -> Void in
                    self.queryBridges(0, limit: 1000)
                }
            }
            else
            {
                pushToBridgeTableViewController()
            }
        }
    }
    
    // see your location changing (if you ever want to)!
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
    }
    
    func queryBridges(skip : Int, limit : Int)
    {
        var query = PFQuery(className: "bridges")
        query.limit = limit
        query.skip = skip
        query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
            if(error == nil)
            {
                bridgesArray.addObjectsFromArray(objects!)
            }
            
            self.value = (Double(bridgesArray.count) / 6543.0) * 100
            self.alert.message = (NSString(format: "%.2f", self.value) as String) + "% Complete"
            self.alert.reloadInputViews()
            
            if(objects!.count == limit)
            {
                self.queryBridges(skip + limit, limit: limit)
            }
            else
            {
                self.alert.self.dismissViewControllerAnimated(false, completion: { () -> Void in
                    self.pushToBridgeTableViewController()
                })
            }
        })
    }
    
    // push to View Controllers methods
    func pushToBridgeTableViewController()
    {
        var navController : UINavigationController = UINavigationController(rootViewController: BridgesTableViewController())
        navController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(navController, animated: true, completion: { () -> Void in
            
        })
    }
    
    func pushToStationsTableViewController()
    {
        var navController : UINavigationController = UINavigationController(rootViewController: StationsTableViewController())
        navController.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(navController, animated: true) { () -> Void in
            self.activityIndiciator.stopAnimating()
            self.activityIndiciator.alpha = 0
        }
    }

}