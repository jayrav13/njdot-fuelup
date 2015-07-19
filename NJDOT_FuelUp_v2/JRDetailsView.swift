//
//  JRDetailsView.swift
//  NJDOT_FuelUp_v2
//
//  Created by Jay Ravaliya on 7/18/15.
//  Copyright (c) 2015 JRav. All rights reserved.
//

import UIKit

class JRDetailsView: UIView {

    // variables
    var opaqueView : UIView!
    var object: NSMutableArray! = []
    
    convenience init()
    {
        self.init()
    }

    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        if self.window != nil
        {
            self.createCustomView(object)
            println(self.object)
        }
    }
    
    func createCustomView(currentObject: NSMutableArray)
    {
        var height: CGFloat = CGFloat(UIScreen.mainScreen().bounds.height)
        var width: CGFloat = CGFloat(UIScreen.mainScreen().bounds.width)
        
        opaqueView = UIView(frame: self.frame)
        opaqueView.backgroundColor = UIColor.blackColor()
        opaqueView.alpha = 0.5
        self.addSubview(opaqueView)
        
        var dataView : UIView = UIView(frame: CGRectMake(width/2.0 - 150, 100, 300.0, height - 200.0))
        dataView.backgroundColor = UIColor.whiteColor()
        self.addSubview(dataView)
        
        var button : UIButton = UIButton(frame: CGRectMake(width/2-50, height/2-50, 100, 50))
        
        if currentObject.count > 0
        {
            if let test: String = currentObject[0]["municipality"] as? String
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
        
        // button.setTitle("Error", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.addSubview(button)

        println("\(dataView.frame.origin.x), \(dataView.frame.origin.y), \(dataView.frame.size.width), \(dataView.frame.size.height)")
        
        var str_no_label : UILabel = UILabel(frame: CGRect(x: dataView.frame.origin.x, y: dataView.frame.origin.y, width: dataView.frame.size.width, height: 100))
        str_no_label.text = currentObject[0]["str_no"] as? String
        str_no_label.textAlignment = NSTextAlignment.Center
        str_no_label.font = UIFont.systemFontOfSize(48)
        self.addSubview(str_no_label)
    }
    
    func buttonPressed(sender: UIButton!)
    {
        UIView.transitionWithView(self.superview!, duration: 0.25, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
                self.removeFromSuperview()
            
            }) { (finished: Bool) -> Void in

        }
    }
}