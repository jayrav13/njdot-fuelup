//
//  JRDetailsView.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/18/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

class JRDetailsView: UIView {

    var county : String!
    var latitude : Double!
    var longitude : Double!
    var mp : Double!
    var municipality : String!
    var owner : String!
    var route : String!
    var str_name : String!
    var str_no : String!
    
    func setTableViewAlpha(view: BridgesTableViewController) {
        view.tableView.alpha = 1
    }
    
    convenience init()
    {
        self.init()
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.createCustomView()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func setValues(county : String, latitude: Double, longitude: Double, mp: Double, municipality: Double, owner: String, route: String, str_name: String, str_no: String)
    {
        
    }
    
    func createCustomView()
    {
        var label : UILabel = UILabel(frame: CGRectMake(0, 0, 200, 200))
        label.backgroundColor = UIColor.blackColor()
        label.text = "Test"
        label.textColor = UIColor.whiteColor()
        self.addSubview(label)
        
        var button : UIButton = UIButton(frame: CGRectMake(0, 0, 200, 200))
        button.setTitle("Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(button)
    }
    
    func buttonPressed(sender: UIButton!)
    {
        self.removeFromSuperview()
    }
    
    
    
    
}
