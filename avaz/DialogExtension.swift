//
//  DialogExtension.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/18/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//




extension UIViewController{

    
    func ShowLoader(msg: String)  {
        let refreshAlert = UIAlertView()
        refreshAlert.title = "Error"
        refreshAlert.message = msg
        refreshAlert.addButtonWithTitle("Cancel")
        refreshAlert.addButtonWithTitle("OK")
        dispatch_async(dispatch_get_main_queue(),{
            refreshAlert.show()
        })
    }

    
    func PauseLoader(msg: String)  {
        
    }
    
    
    
    
    
    
}