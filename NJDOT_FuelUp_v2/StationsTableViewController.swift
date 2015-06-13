//
//  StationsTableViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/12/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit
import Parse

// global stationId variable
var stationId : Int = 0

class StationsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // create tableView
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        // initiate tableView, establish frame, dataSource and delegate
        tableView = UITableView()
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.delegate = self
        
        // register class of "cell" for use later
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // set custom title, add back and map bar buttons, add table to the view!
        self.title = "Stations"
        
        var backBarButton : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        self.navigationItem.leftBarButtonItem = backBarButton
        var mapBarButton : UIBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: "mapButton:")
        self.navigationItem.rightBarButtonItem = mapBarButton
        view.addSubview(tableView)
        tableView.reloadData()
        
    }
    
    // present the initial ViewController via back button
    func backButton(sender: UIButton!)
    {
        presentViewController(ViewController(), animated: true) { () -> Void in
            
        }
    }
    
    // push StationsMapViewController onto stack
    func mapButton(sender: UIButton!)
    {
        self.navigationController?.pushViewController(StationsMapViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
    
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = allStations[Int(sortedStations[indexPath.row]["id"]!!.doubleValue) - 1]["stationName"] as? String
        
        cell.detailTextLabel?.text = String(Int(sortedStations[indexPath.row]["distance"]!!.doubleValue)) + " mi"
        
        cell.textLabel?.font = UIFont(name: "Raleway-Light", size: 20)
        
        cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 16)
        cell.detailTextLabel?.textColor = UIColor.redColor()
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    // push StationsDetailedViewController onto stack. establish stationId so that the next screen can be dynamically loaded with data
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        stationId = Int(sortedStations[indexPath.row]["id"]!!.doubleValue - 1)
        self.navigationController?.pushViewController(StationsDetailViewController(), animated: true)
    }
    
    // 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedStations.count
    }
    
}
