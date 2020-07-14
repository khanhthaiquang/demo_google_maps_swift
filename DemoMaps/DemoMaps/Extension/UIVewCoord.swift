//
//  UIVewCoord.swift
//  DMSmart
//
//  Created by IronMac on 4/4/19.
//  Copyright © 2019 IronTran. All rights reserved.
//

import UIKit

var spinner: UIView!
extension UIView {
    
    var left:CGFloat
    {
        set(x)
        {
            var frame:CGRect=self.frame
            frame.origin.x=round(x)
            self.frame=frame
        }
        get
        {
            return self.frame.origin.x
        }
    }
    
    
    var top:CGFloat
    {
        set(y)
        {
            var frame:CGRect=self.frame
            frame.origin.y=round(y)
            self.frame=frame
        }
        get
        {
            return self.frame.origin.y
        }
    }
    
    
    var width:CGFloat
    {
        set(width)
        {
            var frame:CGRect=self.frame
            frame.size.width = round(width)
            self.frame = frame
        }
        get
        {
            return self.frame.size.width
        }
    }
    
    var height:CGFloat
    {
        set(height)
        {
            var frame:CGRect=self.frame
            frame.size.height = round(height)
            self.frame = frame
        }
        get
        {
            return self.frame.size.height
        }
    }
    
    var right:CGFloat
    {
        set(right)
        {
            var frame:CGRect=self.frame
            frame.origin.x = round(right-self.width)
            self.frame = frame
        }
        get
        {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    
    var bottom:CGFloat
    {
        set(bottom)
        {
            var frame:CGRect=self.frame
            frame.origin.y = round(bottom-self.height)
            self.frame = frame
        }
        get
        {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    func dropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func bottomShadow(weight:Float) {
        let rect = CGRect(x: self.bounds.origin.x + CGFloat(weight/2), y: self.bounds.origin.y + self.bounds.size.height, width: self.bounds.size.width - CGFloat(weight), height: CGFloat(weight))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = CGFloat(weight)
        self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func topShadow(weight:Float) {
        let rect = CGRect(x: self.bounds.origin.x + CGFloat(weight/2), y: self.bounds.origin.y-CGFloat(weight), width: self.bounds.size.width - CGFloat(weight), height: CGFloat(weight))
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = CGFloat(weight)
        self.layer.shadowPath = UIBezierPath(rect: rect).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    func setCardFrame() -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10)
        self.layer.cornerRadius = 10
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 1
        self.layer.shadowPath = path.cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setFullShadow(radius:Float, shadowRadius:Float) -> Void {
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: CGFloat(radius))
        self.layer.cornerRadius = CGFloat(radius)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowPath = path.cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    enum ViewSide {
        case left, right, top, bottom, full
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: bounds.minX, y: bounds.minY, width: thickness, height: bounds.height)
            layer.addSublayer(border)
        case .right: border.frame = CGRect(x: bounds.maxX-1, y: bounds.minY, width: thickness, height: bounds.height)
            layer.addSublayer(border)
        case .top: border.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: thickness)
            layer.addSublayer(border)
        case .bottom: border.frame = CGRect(x: bounds.minX, y: bounds.maxY-1, width: bounds.width, height: thickness)
            layer.addSublayer(border)
        case .full:
            let topBorder = CALayer()
            topBorder.backgroundColor = color
            let leftBorder = CALayer()
            leftBorder.backgroundColor = color
            let rightBorder = CALayer()
            rightBorder.backgroundColor = color
            let bottomBorder = CALayer()
            bottomBorder.backgroundColor = color
            
            topBorder.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width, height: thickness)
            leftBorder.frame = CGRect(x: bounds.minX, y: bounds.minY, width: thickness, height: bounds.height)
            rightBorder.frame = CGRect(x: bounds.maxX-1, y: bounds.minY, width: thickness, height: bounds.height)
            bottomBorder.frame = CGRect(x: bounds.minX, y: bounds.maxY-1, width: bounds.width, height: thickness)
            
            layer.addSublayer(topBorder)
            layer.addSublayer(leftBorder)
            layer.addSublayer(rightBorder)
            layer.addSublayer(bottomBorder)
        }
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UITabBarController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    func showSpinner(onView: UIView) {
        let spinnerView = UIView.init(frame: self.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
        let ai = UIActivityIndicatorView.init(style: .gray)
        ai.sizeThatFits(CGSize(width: 24, height: 24))
        ai.startAnimating()
        ai.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.addSubview(spinnerView)
        }
        spinner = spinnerView
    }
    
    func removeSpinnerView() {
        if spinner != nil {
            spinner.removeFromSuperview()
            spinner = nil
        }
    }
}

extension Bundle {
    func LocalizedString(key:String) -> String {
        return NSLocalizedString(key, comment: "EXTENSION LOCALIZE");
    }
}
extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
