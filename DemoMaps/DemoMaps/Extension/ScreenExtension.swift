//
//  ScreenExtension.swift
//  ETicket
//
//  Created by GMO on 12/18/19.
//  Copyright © 2019 Home. All rights reserved.
//


import UIKit
extension UIScreen {
    static var size: CGSize  {
        return UIScreen.main.bounds.size
    }
   
    static var width: CGFloat  {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
}
