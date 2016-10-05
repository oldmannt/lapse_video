//
//  GalleryTabBarController.swift
//  lapse_app
//
//  Created by dyno on 8/13/16.
//  Copyright © 2016 dyno. All rights reserved.
//

import UIKit

class GalleryTabBarController: UITabBarController {
    override func viewDidLoad() {
        
        var tabFrame: CGRect = self.tabBar.frame
        tabFrame.size.height = 40
        tabFrame.origin.y = self.view.frame.size.height*2
        self.tabBar.frame = tabFrame
        
        //self.view.addConstraint(NSLayoutConstraint(item: self.tabBar, attribute: NSLayoutAttribute.Top, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1.0, constant: 0))
    }
}
