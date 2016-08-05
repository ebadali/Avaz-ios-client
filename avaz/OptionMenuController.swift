//
//  OptionMenuController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class OptionMenuController: UITableViewController {
    
    var count =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("***OptionMenuController did load")
        self.title = "OptionMenuController"
        
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        print(identifier)
        count = count + 1
        return UserData.sharedInstance.GetControllerType().rawValue != identifier
    }
    

    
}
