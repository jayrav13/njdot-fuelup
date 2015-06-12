//
//  StationsTableViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 6/12/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

var stationId : Int = 0

class StationsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        tableView = UITableView()
        tableView.frame = view.frame
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.title = "List of Stations"
        
        var backBarButton : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        
        self.navigationItem.leftBarButtonItem = backBarButton
        
        var mapBarButton : UIBarButtonItem = UIBarButtonItem(title: "Map", style: UIBarButtonItemStyle.Plain, target: self, action: "mapButton:")
        
        self.navigationItem.rightBarButtonItem = mapBarButton
        
        view.addSubview(tableView)
        
    }
    
    func backButton(sender: UIButton!)
    {
        presentViewController(ViewController(), animated: true) { () -> Void in
            
        }
    }
    
    func mapButton(sender: UIButton!)
    {
        self.navigationController?.pushViewController(StationsMapViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.text = "Row \(indexPath.row)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        stationId = indexPath.row
        self.navigationController?.pushViewController(StationsDetailViewController(), animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
}
