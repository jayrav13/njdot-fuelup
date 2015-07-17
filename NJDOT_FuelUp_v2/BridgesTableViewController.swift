//
//  BridgesTableViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/16/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

class BridgesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {

    var searchBar : UISearchBar!
    var tableView : UITableView!
    let searchController : UISearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Search Bridge"
        
        var backButton : UIBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        self.navigationItem.leftBarButtonItem = backButton
        
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar
        
        println(bridgesArray.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bridgesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell.textLabel?.text = "Bridge: " + (bridgesArray[indexPath.row]["str_no"] as! String)
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // println(searchController.searchBar.text)
        
    }
    
    func backButton(sender: UIButton!)
    {
        presentViewController(ViewController(), animated: true) { () -> Void in
            
        }
    }
    

    
}
