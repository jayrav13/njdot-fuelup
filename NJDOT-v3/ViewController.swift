//
//  ViewController.swift
//  NJDOT-v3
//
//  Created by Jay Ravaliya on 1/27/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    var tableView : UITableView!
    var refreshControl : UIRefreshControl!
    var segmentedControl : UISegmentedControl!
    
    var mapBarButtonItem : UIBarButtonItem!
    
    var locationManager : CLLocationManager!
    
    var data : [String : JSON]!
    
    var activityIndicator : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.segmentedControl = UISegmentedControl(items: ["Stations", "Bridges"])
        self.segmentedControl.addTarget(self, action: "segmentedControlTapped:", forControlEvents: UIControlEvents.ValueChanged)
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.frame = CGRect(x: Standard.screenWidth / 2 - 75, y: (self.navigationController?.navigationBar.frame.size.height)!/2 - 14, width: 150, height: 28)
        self.navigationController?.navigationBar.addSubview(self.segmentedControl)
        
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: "refreshControlPulled:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl)
        
        self.activityIndicator = UIActivityIndicatorView()
        self.activityIndicator.color = UIColor.blackColor()
        self.activityIndicator.frame = CGRect(x: Standard.screenWidth / 2 - 20, y: Standard.screenHeight / 2 - 20, width: 40, height: 40)
        self.activityIndicator.alpha = 0
        self.view.addSubview(self.activityIndicator)
        
        self.mapBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: "mapBarButtonItemPressed:")
        self.navigationItem.rightBarButtonItem = self.mapBarButtonItem
        
        self.data = ["stations" : [], "bridges" : []]
        self.getData(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.segmentedControl.alpha = 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        if(self.segmentedControl.selectedSegmentIndex == 0) {
            cell?.textLabel?.text = self.data["stations"]![indexPath.row]["stationName"].stringValue
        }
        else {
            cell?.textLabel?.text = self.data["bridges"]![indexPath.row]["bridgeName"].stringValue
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.segmentedControl.selectedSegmentIndex == 0) {
            return self.data["stations"]!.count
        }
        else {
            return self.data["stations"]!.count
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // print(locationManager.location?.coordinate)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.getData(true)
    }
    
    /*
     *  Top Segmented Control
     */
    func segmentedControlTapped(segmentedControl : UISegmentedControl) {
        self.getData(false)
    }
    
    /*
     *  Refresh Control - pull to refresh
     */
    func refreshControlPulled(sender : UIRefreshControl) {
        self.getData(true)
    }
    
    func getData(repull : Bool) {
        
        if(self.segmentedControl.selectedSegmentIndex == 0 && (self.data["stations"]!.count == 0 || repull)) {
            
            if(self.data["stations"]!.count == 0) {
                self.tableView.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
            }
            
            API.getStations((self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, completion: { (success, data) -> Void in
                
                if(success) {
                    self.setDataValue("stations", data: data)
                    self.tableView.reloadData()
                    self.tableView.alpha = 1
                    self.activityIndicator.alpha = 0
                    self.activityIndicator.stopAnimating()
                }
                else {
                    // error
                }
                
                self.refreshControl.endRefreshing()
                
            })
        }
        else if (self.segmentedControl.selectedSegmentIndex == 1 && (self.data["bridges"]!.count == 0 || repull)) {

            if(self.data["bridges"]!.count == 0) {
                self.tableView.alpha = 0
                self.activityIndicator.alpha = 1
                self.activityIndicator.startAnimating()
            }

            API.getBridges((self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!, completion: { (success, data) -> Void in
                
                if(success) {
                    self.setDataValue("bridges", data: data)
                    self.tableView.reloadData()
                    self.tableView.alpha = 1
                    self.activityIndicator.alpha = 0
                    self.activityIndicator.stopAnimating()
                }
                else {
                    // error
                }
                
                self.refreshControl.endRefreshing()
                
            })
        }
        else {
            self.tableView.reloadData()
        }
    }
    
    func setDataValue(index : String, data : JSON) {
        self.data[index] = data
    }
    
    func mapBarButtonItemPressed(sender : UIButton) {
        let mvc : MapViewController = MapViewController()
        mvc.latitude = self.locationManager.location?.coordinate.latitude
        mvc.longitude = self.locationManager.location?.coordinate.longitude
        
        if(self.segmentedControl.selectedSegmentIndex == 0) {
            mvc.dataType = "stations"
            mvc.data = self.data["stations"]
        }
        else {
            mvc.dataType = "bridges"
            mvc.data = self.data["bridges"]
        }
        
        if(self.data[mvc.dataType]!.count != 0) {
            self.segmentedControl.alpha = 0
            self.navigationController?.pushViewController(mvc, animated: true)
        }
        else {
            // Data still loading, wait yo.
        }
        
    }
}

