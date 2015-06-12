//
//  ViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/10/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit
import Parse
import CoreLocation

// establish variables for screen size
var screenWidth : CGFloat = 0.0
var screenHeight : CGFloat = 0.0

// fonts - set during viewDidLoad of this method, for use throughout app
var microFontRegular : UIFont!
var microFontBold : UIFont!

// location
var manager : CLLocationManager!

class ViewController: UIViewController, CLLocationManagerDelegate {

    // labels
    var mainLabel : UILabel!
    var creditsLabel : UILabel!
    
    // buttons
    var stationsButton : UIButton!
    var bridgesButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // calculate screen width and height for the entire screen, 
        // used throughout the app
        screenWidth = UIScreen.mainScreen().bounds.width
        screenHeight = UIScreen.mainScreen().bounds.height
        
        // establish location
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // establish micro font
        microFontRegular = UIFont(name: "MicroFLF", size: 30)
        microFontBold = UIFont(name: "MicroFLF-Bold", size: 30)
        
        view.backgroundColor = UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
        
        // establish mainLabel
        mainLabel = UILabel()
        mainLabel.frame = CGRectMake(screenWidth/2 - 150, screenHeight/6 - 50, 300, 100)
        mainLabel.text = "NJ Fuel Up v2.0"
        mainLabel.textAlignment = NSTextAlignment.Center
        mainLabel.font = microFontBold
        view.addSubview(mainLabel)
        
        // credits
        creditsLabel = UILabel()
        creditsLabel.frame = CGRectMake(0, screenHeight-25, screenWidth, 25)
        creditsLabel.backgroundColor = UIColor.blackColor()
        creditsLabel.text = "By Jay Ravaliya, Parth Oza 2015"
        creditsLabel.textAlignment = NSTextAlignment.Center
        creditsLabel.font = UIFont(name: "MicroFLF", size: 12)
        creditsLabel.textColor = UIColor.whiteColor()
        view.addSubview(creditsLabel)
        
        // establish Stations and Bridges buttons
        // stations button
        stationsButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        stationsButton.addTarget(self, action: "stationsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        stationsButton.frame = CGRectMake(screenWidth/2 - 100, screenHeight/2, 200, 75)
        stationsButton.setTitle("Stations", forState: UIControlState.Normal)
        stationsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        stationsButton.titleLabel!.font = microFontRegular
        stationsButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        stationsButton.backgroundColor = UIColor.clearColor()
        stationsButton.layer.cornerRadius = 5
        stationsButton.layer.borderWidth = 1
        stationsButton.layer.borderColor = UIColor.blackColor().CGColor
        
        // bridges button
        bridgesButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        bridgesButton.addTarget(self, action: "bridgesPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        bridgesButton.frame = CGRectMake(screenWidth/2 - 100, screenHeight/4 + 50, 200, 75)
        bridgesButton.setTitle("Bridges", forState: UIControlState.Normal)
        bridgesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Center
        bridgesButton.titleLabel!.font = microFontRegular
        bridgesButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        bridgesButton.backgroundColor = UIColor.clearColor()
        bridgesButton.layer.cornerRadius = 5
        bridgesButton.layer.borderWidth = 1
        bridgesButton.layer.borderColor = UIColor.blackColor().CGColor
        
        
        view.addSubview(stationsButton)
        view.addSubview(bridgesButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // what to do when stations or bridges buttons are pressed
    func stationsPressed(sender: UIButton!)
    {
        println("Stations pressed!")
        presentViewController(StationsTableViewController(), animated: true) { () -> Void in
            
        }
    }
    
    func bridgesPressed(sender: UIButton!)
    {
        println("Bridges pressed!")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
    }


}

