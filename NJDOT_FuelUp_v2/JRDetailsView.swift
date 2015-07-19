//
//  JRDetailsView.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/18/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

public class JRDetailsView: UIView {

    // variables
    var opaqueView : UIView!
    var object: NSMutableArray!
    
    convenience init()
    {
        self.init()
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.createCustomView()
    }
    
    required public init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func createCustomView()
    {
        var height: CGFloat = CGFloat(UIScreen.mainScreen().bounds.height)
        var width: CGFloat = CGFloat(UIScreen.mainScreen().bounds.width)
        
        opaqueView = UIView(frame: self.frame)
        opaqueView.backgroundColor = UIColor.blackColor()
        opaqueView.alpha = 0.5
        self.addSubview(opaqueView)
        
        var label : UILabel = UILabel(frame: CGRectMake(width/2.0 - 150, 100, 300.0, height - 200.0))
        label.backgroundColor = UIColor.whiteColor()
        label.text = "Test"
        label.textColor = UIColor.blackColor()
        self.addSubview(label)
        
        var button : UIButton = UIButton(frame: CGRectMake(width/2-50, height/2-50, 100, 50))
        
        if object.count > 0
        {
            if let test: String = object[0]["municipality"] as? String
            {
                button.setTitle(test, forState: UIControlState.Normal)
            }
            else
            {
                button.setTitle("Error", forState: UIControlState.Normal)
            }
        }
        else
        {
            button.setTitle("Error", forState: UIControlState.Normal)
        }

        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.addSubview(button)
        
    }
    
    func buttonPressed(sender: UIButton!)
    {
        UIView.transitionWithView(self.superview!, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
                self.removeFromSuperview()
            
            }) { (finished: Bool) -> Void in

        }
    }
    
    
    
    
}
