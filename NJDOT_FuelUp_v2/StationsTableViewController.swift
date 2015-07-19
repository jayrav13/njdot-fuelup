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
var sortedId : Int = 0

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
        
        // set up both back and map buttons on the top navigation bar, add the tableview to the view and reload data
        var backBarButton : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        self.navigationItem.leftBarButtonItem = backBarButton
        var mapBarButton : UIBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: "mapButton:")
        self.navigationItem.rightBarButtonItem = mapBarButton
        view.addSubview(tableView)
        
    }
    
    // present the initial ViewController via back button
    func backButton(sender: UIButton!)
    {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    // push StationsMapViewController onto stack
    func mapButton(sender: UIButton!)
    {
        self.navigationController?.pushViewController(StationsMapViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // establish cell at row, with details
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // set up cell variable, and then reset it to show new style
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        
        // set up textLabel and detailTextLabel
        cell.textLabel?.text = allStations[Int(sortedStations[indexPath.row]["id"]!!.doubleValue) - 1]["stationName"] as? String
        cell.textLabel?.font = UIFont(name: "Raleway-Light", size: 20)
        
        cell.detailTextLabel?.text = String(stringInterpolationSegment: Double(Int(sortedStations[indexPath.row]["distance"]!!.doubleValue * 100))/100) + " mi"
        cell.detailTextLabel?.font = UIFont(name: "Raleway-Light", size: 16)
        cell.detailTextLabel?.textColor = UIColor.redColor()
        
        // return cell
        return cell
    }
    
    // change height of each row to 60 (default 45)
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    // push StationsDetailedViewController onto stack. establish stationId so that the next screen can be dynamically loaded with data
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        stationId = Int(sortedStations[indexPath.row]["id"]!!.doubleValue - 1)
        sortedId = Int(indexPath.row)
        self.navigationController?.pushViewController(StationsDetailViewController(), animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // return the number of stations in the sortedStations array. returning this or returning
    // the regular array should make no difference.
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedStations.count
    }
    
}
