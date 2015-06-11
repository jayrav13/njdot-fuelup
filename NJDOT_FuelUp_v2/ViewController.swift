//
//  ViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/10/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit
import Parse

// establish variables for screen size
var screenWidth : CGFloat = 0.0
var screenHeight : CGFloat = 0.0

class ViewController: UIViewController {

    // labels and buttons
    var mainLabel : UILabel!
    var stationsButton : UIButton!
    var bridgesButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // calculate screen width and height for the entire screen, 
        // used throughout the app
        screenWidth = UIScreen.mainScreen().bounds.width
        screenHeight = UIScreen.mainScreen().bounds.height
        
        // establish mainLabel
        mainLabel = UILabel()
        mainLabel.frame = CGRectMake(screenWidth/2 - 150, screenHeight/6 - 50, 300, 100)
        mainLabel.text = "NJ Fuel Up v2.0"
        mainLabel.textAlignment = NSTextAlignment.Center
        mainLabel.font = UIFont(name: "Helvetica Neue", size: 30)
        view.addSubview(mainLabel)
        
        // establish Stations and Bridges buttons
        stationsButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        bridgesButton = UIButton.buttonWithType(UIButtonType.System) as! UIButton
        stationsButton.addTarget(self, action: "stationsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        bridgesButton.addTarget(self, action: "bridgesPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        stationsButton.frame = CGRectMake(screenWidth/2 - 100, screenHeight/2, 100, 100)
        bridgesButton.frame = CGRectMake(screenWidth/2 + 100, screenHeight/2, 100, 100)
        stationsButton.setTitle("Stations Button", forState: UIControlState.Normal)
        bridgesButton.setTitle("Bridges Button", forState: UIControlState.Normal)
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
    }
    
    func bridgesPressed(sender: UIButton!)
    {
        println("Bridges pressed!")
    }


}

