//
//  NavigationController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/18/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation


extension UINavigationController {
    public override func shouldAutorotate() -> Bool {
        return false
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
}