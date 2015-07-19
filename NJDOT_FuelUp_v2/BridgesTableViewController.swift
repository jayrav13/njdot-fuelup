//
//  BridgesTableViewController.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/16/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

// global variables used by other views
var searchResults : NSMutableArray!
var isBlank : Bool = true

class BridgesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating, UISearchBarDelegate {

    // set up search bar, tableView
    var tableView : UITableView!
    let searchController : UISearchController = UISearchController(searchResultsController: nil)
    
    // add variables for height/width
    var height : CGFloat = UIScreen.mainScreen().bounds.height
    var width : CGFloat = UIScreen.mainScreen().bounds.width
    
    // bar button items
    var backButton : UIBarButtonItem!
    
    // sets up DetailsView View and opaqueView
    var opaqueView : UIView!
    var jr : JRDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background color of viewcontroller to white and set navItem title
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Search Bridge"
        
        // add to bar button items
        backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        self.navigationItem.leftBarButtonItem = backButton
        
        // set up tableView
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        // set up searchController
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.delegate = self
        self.tableView.tableHeaderView = searchController.searchBar
        
        // set up searchResults array to have nothing
        searchResults = []
        
        // when loaded, searchController should be blank with no text
        isBlank = true
        searchController.searchBar.text = ""
        
        jr = JRDetailsView(frame: view.frame)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // when row is selected
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // if the user is typing something, dismiss this viewcontroller first
        if searchController.view.window != nil
        {
            searchController.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
        
        // variable for object associated with row selected
        var currentObject : NSMutableArray! = []
        
        // if the search is blank, the tableView will be displaying data from the bridgesArray
        // else, it will be displaying data from the searchResults array
        if(isBlank == true)
        {
            currentObject.addObject(bridgesArray[indexPath.row])
        }
        else
        {
            currentObject.addObject(searchResults[indexPath.row])
        }
        
        // new button for users to navigate to bridge
        let navigate = UIAlertAction(title: "Navigate", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in

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
        
        jr.object = currentObject
        // present the view and deselect the row directly after
        
        UIView.transitionWithView(self.view, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
                self.view.addSubview(self.jr)
            
            }) { (finished: Bool) -> Void in
                
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // determine how many rows are in the main section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // if the search box is blank, the number of rows will be the total number of 
        // structures
        if(isBlank == true)
        {
            return bridgesArray.count
        }
        // otherwise, check how many objects are in searchResults
        // if none, just return 1
        // else, return the number of rows in searchResults
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
    
    // for each cell in the tableView
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue cell, establish cell using the subtitle style, align everything left to start
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        
        // if the search is blank
        if(isBlank == true)
        {
            // set up the primary text using the Structure No
            cell.textLabel?.text = "Structure No: " + (bridgesArray[indexPath.row]["str_no"] as! String)
            
            // safely unwrap the street name and municipality
            // if both exists, add them to the tableView
            // else, show that it is unavailable
            if let str_name : String = bridgesArray[indexPath.row]["str_name"] as? String
            {
                if let municipality : String = bridgesArray[indexPath.row]["municipality"] as? String
                {
                    cell.detailTextLabel?.text = (bridgesArray[indexPath.row]["str_name"] as! String) + ", " + (bridgesArray[indexPath.row]["municipality"] as! String)
                }
                else
                {
                    cell.detailTextLabel?.text = "Street and Municipality Unavailable"
                }
            }
            else
            {
                cell.detailTextLabel?.text = "Street and Municipality Unavailable"
            }
            
            
        }
        // if the user is currently searching
        else
        {
            // if there is no matching result, use a default cell center-aligned and notify
            // user that there is no result found
            if(searchResults.count == 0)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                cell.textLabel?.text = "No results found."
            }
            // otherwise, do what we did earlier and list out Structure No and str_name/municipality if they exist
            else
            {
                cell.textLabel?.text = "Structure No: " + (searchResults[indexPath.row]["str_no"] as! String)
                if let str_name : String = searchResults[indexPath.row]["str_name"] as? String
                {
                    if let municipality : String = searchResults[indexPath.row]["municipality"] as? String
                    {
                        cell.detailTextLabel?.text = (searchResults[indexPath.row]["str_name"] as! String) + ", " + (searchResults[indexPath.row]["municipality"] as! String)
                    }
                    else
                    {
                        cell.detailTextLabel?.text = "Street and Municipality Unavailable"
                    }
                }
                else
                {
                    cell.detailTextLabel?.text = "Street and Municipality Unavailable"
                }
            }
        }
    
        // return the cell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    // each time the user changes the search box entry, update the searchResults array and refresh tableView
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        // if there is text in the searchBar
        if count(searchController.searchBar.text) != 0
        {
            // clean searchResults query, change bool value and get ready for an O(n) search on bridgesArray to find matches
            searchResults = []
            isBlank = false
            
            // search all objects and add matching objects (non-case-sensitive) to searchResults
            for var i = 0; i < bridgesArray.count; i++
            {
                if (((bridgesArray[i]["str_no"] as! String).uppercaseString).rangeOfString((searchController.searchBar.text).uppercaseString) != nil)
                {
                    searchResults.addObject(bridgesArray[i])
                }
            }
        }
        // if blank, just change boolean - the output will be handled by the tableView delegate methods
        else
        {
            isBlank = true
        }

        // reload all data in tableView
        tableView.reloadData()
    }
    
    // dismiss viewcontroller after making sure that searchController has been dismissed
    func backButton(sender: UIButton!)
    {
        if searchController.view.window != nil
        {
            searchController.dismissViewControllerAnimated(true, completion: { () -> Void in

            })
        }
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    // clear text when cancel button is clicked
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isBlank = true
        tableView.reloadData()
        
    }

    
}
