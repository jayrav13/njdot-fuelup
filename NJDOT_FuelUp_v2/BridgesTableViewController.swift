//
//  BridgesTableViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/16/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

var searchResults : NSMutableArray!
var isBlank : Bool = true

class BridgesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

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
        
        searchResults = []
        
        searchController.searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isBlank == true)
        {
            return bridgesArray.count
        }
        else
        {
            if(searchResults.count == 0)
            {
                return 1
            }
            else
            {
                return searchResults.count
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        
        if(isBlank == true)
        {
            cell.textLabel?.text = "Bridge: " + (bridgesArray[indexPath.row]["str_no"] as! String)
        }
        else
        {
            if(searchResults.count == 0)
            {
                cell.textLabel?.text = "No results found."
                cell.textLabel?.textAlignment = NSTextAlignment.Center
            }
            else
            {
                cell.textLabel?.text = "Bridge: " + (searchResults[indexPath.row]["str_no"] as! String)
            }
        }
        
        return cell
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // println(searchController.searchBar.text)
        if count(searchController.searchBar.text) != 0
        {
            searchResults = []
            isBlank = false
            for var i = 0; i < bridgesArray.count; i++
            {
                if ((bridgesArray[i]["str_no"] as! String).rangeOfString(searchController.searchBar.text) != nil)
                {
                    searchResults.addObject(bridgesArray[i])
                }
            }
        }
        else
        {
            isBlank = true
        }

        tableView.reloadData()
    }
    
    func backButton(sender: UIButton!)
    {
        presentViewController(ViewController(), animated: true) { () -> Void in
            
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isBlank = true
        tableView.reloadData()
    }

    
}
