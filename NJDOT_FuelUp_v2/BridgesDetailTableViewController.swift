//
//  BridgesDetailTableViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/21/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

class BridgesDetailTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentObject: NSMutableArray! = []
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        // tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        if indexPath.row == 0 || indexPath.row == 1
        {
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            
            switch indexPath.row
            {
            
            case 0:
                cell.textLabel?.text = currentObject[0]["str_name"] as? String
                cell.textLabel?.font = UIFont.boldSystemFontOfSize(24)
                cell.textLabel?.adjustsFontSizeToFitWidth = true
            case 1:
                cell.textLabel?.text = "Bridge Information"
                cell.textLabel?.font = UIFont.boldSystemFontOfSize(16)
            
            default:
                cell.textLabel?.text = "Error"
            }
        }
        else if indexPath.row > 1 && indexPath.row < 10
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
            switch indexPath.row {
                
            case 2:
                cell.textLabel?.text = "Structure No"
                cell.detailTextLabel?.text = currentObject[0]["str_no"] as? String
                cell.textLabel?.adjustsFontSizeToFitWidth = true
            
            case 3:
                cell.textLabel?.text = "Coordinates"
                cell.detailTextLabel?.text = String(format: "%.2f", currentObject[0]["latitude"] as! Double) + ", " + String(format: "%.2f", currentObject[0]["longitude"] as! Double)
            
            case 4:
                cell.textLabel?.text = "MP Value"
                cell.detailTextLabel?.text = String(format: "%.2f", currentObject[0]["mp"] as! Double)
                
            case 5:
                cell.textLabel?.text = "Municipality"
                cell.detailTextLabel?.text = currentObject[0]["municipality"] as? String
            
            case 6:
                cell.textLabel?.text = "Owner"
                cell.detailTextLabel?.text = currentObject[0]["owner"] as? String
                
            case 7:
                cell.textLabel?.text = "Route"
                cell.detailTextLabel?.text = currentObject[0]["route"] as? String
                
            case 8:
                cell.textLabel?.text = "County"
                cell.detailTextLabel?.text = currentObject[0]["county"] as? String
                
            case 9:
                cell.textLabel?.text = ""
                
            default:
                cell.textLabel?.text = "Error"
            
            }
        }
        else if indexPath.row == 10
        {
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.text = "Navigate"
            cell.textLabel?.font = UIFont.boldSystemFontOfSize(24)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == tableView.numberOfRowsInSection(0) - 1
        {
            var latitude : Double = currentObject[0]["latitude"] as! Double
            var longitude : Double = currentObject[0]["longitude"] as! Double
            
            if UIApplication.sharedApplication().openURL(NSURL(string: "comgooglemaps://?q=\(latitude),\(longitude)")!)
            {
                UIApplication.sharedApplication().openURL(NSURL(string: "comgooglemaps://?q=\(latitude),\(longitude)")!)
            }
            else
            {
                UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.google.com/?q=\(latitude),\(longitude)")!)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
}
