//
//  OptionMenuController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON

class OptionMenuController: UITableViewController {
    
    
    @IBOutlet weak var logoutCell: UITableViewCell!
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileUsername: UILabel!
    
    lazy var logOutCallBack:UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer()
        
        //Gesture configuration
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        /*Add the target (You can use UITapGestureRecognizer's init() for this)
         This method receives two arguments, a target(in this case is my ViewController)
         and the callback, or function that you want to invoke when the user tap it view)*/
        gestureRecognizer.addTarget(self, action: #selector(self.LogOut(_:)))
        
//        //Add this gesture to your view, and "turn on" user interaction

        return gestureRecognizer
    }()
    
    
    func LogOut(sender: AnyObject) {
        
        
        print("In Lgout")
        
        UserData.sharedInstance.ClearAll()
        ApiManager.sharedInstance.logOut({(json : JSON) in
            
            if (json != nil )
            {

                
                //Todo: Redirect To SomeWhere
                print("Login \n\(json)")
                
                
                ApiManager.sharedInstance.getAllPost { (json : JSON) in
                    
                    if (json != nil )
                    {
                        //Todo: Redirect To SomeWhere
                        print("Finished Logout")
                    }
                    
                }
            }
            
            }
        )
        
    }
    
    
    var count =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("***OptionMenuController did load")

        
        logoutCell.addGestureRecognizer(logOutCallBack)
        logoutCell.userInteractionEnabled = true
        
        
        if let userUrl = UserData.sharedInstance.currentUser
        {
            profileImage.loadImageUsingCacheWithUrlString((userUrl.PicId) as String)
            profileUsername.text = (userUrl.UserName) as String
            
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        print(identifier)
        count = count + 1
        return UserData.sharedInstance.GetControllerType().rawValue != identifier
    }

    
    
    
}
