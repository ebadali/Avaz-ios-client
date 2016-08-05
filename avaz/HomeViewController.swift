//
//  HomeViewController.swift
//  avaz
//
//  Created by ebad ali on 8/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,  HamburgerProtocol{
    
    
    var controllerType = ControllerType.HOME
    @IBOutlet weak var menuITem: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "HomeViewController"
        // Do any additional setup after loading the view, typically from a nib.
        print("HomeViewController did load")
//        self.revealViewController().delegate = self;
        setupHamburger()
        
        let isLoggedIn:String = UserData.sharedInstance.sessionId!
        if (isLoggedIn == "") {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } 
    }

    func setupHamburger()  {
        if self.revealViewController() != nil {
            menuITem.target = self.revealViewController()
            menuITem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        UserData.sharedInstance.SetControllerType(self.controllerType)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_login" {
            
            //            if let fourthSeq: ScreenFour = segue.destinationViewController as? ScreenFour{
            //                let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
            //                fourthSeq.data = self.someDataSource[(selectedIndex?.row)!]
            //            }
        }else{
            
            
            
        }
    }
    
    
    
    
}
