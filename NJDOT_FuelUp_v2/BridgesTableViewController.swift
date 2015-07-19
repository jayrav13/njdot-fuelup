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
    
    var height : CGFloat = UIScreen.mainScreen().bounds.height
    var width : CGFloat = UIScreen.mainScreen().bounds.width
    
    var backButton : UIBarButtonItem!
    var anotherButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "Search Bridge"
        
        backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backButton:")
        self.navigationItem.leftBarButtonItem = backButton
        
        anotherButton = UIBarButtonItem(title: "Test", style: UIBarButtonItemStyle.Plain, target: self, action: "anotherButtonTest:")
        self.navigationItem.rightBarButtonItem = anotherButton
        
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
        
        isBlank = true
        searchController.searchBar.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var jr : JRDetailsView = JRDetailsView(frame: CGRectMake(UIScreen.mainScreen().bounds.width/2-100, 100, 200, 300))
    
    func anotherButtonTest(sender: UIButton!)
    {
        /*let alert: UIAlertController = UIAlertController(title: "Loading...", message: "0% Complete\nTest", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Test", style: UIAlertActionStyle.Cancel, handler: { (action : UIAlertAction!) -> Void in
            
        }))
        
        self.presentViewController(alert, animated: true) { () -> Void in
            println("Worked")
        }*/
        

        if jr.window != nil
        {
            jr.removeFromSuperview()
            tableView.alpha = 1
            tableView.userInteractionEnabled = true
        }
        else
        {
            view.addSubview(jr)
            tableView.alpha = 0.25
            jr.alpha = 1
            tableView.userInteractionEnabled = false
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchController.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        let alertController = UIAlertController(title: "Details", message: "Message", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action: UIAlertAction!) -> Void in
            
        }
        
        var currentObject : NSMutableArray! = []
        if(isBlank == true)
        {
            currentObject.addObject(bridgesArray[indexPath.row])
        }
        else
        {
            currentObject.addObject(searchResults[indexPath.row])
        }
        
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
        
        alertController.addAction(cancel)
        alertController.addAction(navigate)
        
        self.presentViewController(alertController, animated: true) { () -> Void in

        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.textAlignment = NSTextAlignment.Left
        
        if(isBlank == true)
        {
            cell.textLabel?.text = "Structure No: " + (bridgesArray[indexPath.row]["str_no"] as! String)
            
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
        else
        {
            if(searchResults.count == 0)
            {
                cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
                cell.textLabel?.textAlignment = NSTextAlignment.Center
                cell.textLabel?.text = "No results found."
            }
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
                if (((bridgesArray[i]["str_no"] as! String).uppercaseString).rangeOfString((searchController.searchBar.text).uppercaseString) != nil)
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
        if searchController.view.window != nil
        {
            searchController.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        isBlank = true
        tableView.reloadData()
        
    }

    
}
