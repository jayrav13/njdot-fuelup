//
//  ViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/10/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

var screenWidth : CGFloat = 0.9
var screenHeight : CGFloat = 0.0

class ViewController: UIViewController {

    var mainLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // calculate screen width and height for the entire app
        screenWidth = UIScreen.mainScreen().bounds.width
        screenHeight = UIScreen.mainScreen().bounds.height
        
        mainLabel = UILabel()
        mainLabel.frame = CGRectMake(screenWidth/2 - 100, screenHeight/4 - 100, 200, 200)
        mainLabel.text = "Welcome to NJ Fuel Up!"
        mainLabel.textAlignment = NSTextAlignment.Center
        view.addSubview(mainLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

