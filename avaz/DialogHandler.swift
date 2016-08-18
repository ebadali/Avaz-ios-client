//
//  DialogHandler.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/18/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation


class DialogHandler {
    
    lazy var info:UIAlertView = {
        var refreshAlert = UIAlertView()
        refreshAlert.title = "Info"
        refreshAlert.message = "All data will be lost."
        refreshAlert.addButtonWithTitle("Cancel")
        refreshAlert.addButtonWithTitle("OK")
//        refreshAlert.show()
        
        return refreshAlert
    }()
    
    lazy var error:UIAlertView = {
        var refreshAlert = UIAlertView()
        refreshAlert.title = "Error"
        refreshAlert.message = "All data will be lost."
        refreshAlert.addButtonWithTitle("OK")
        
        return refreshAlert
    }()
    
    static let sharedInstance = DialogHandler()
    
    private init()
    {
        
    }
    
    func ShowInfo(mesage: String)  {
        dispatch_async(dispatch_get_main_queue(),{
            self.info.message = mesage
            self.info.show()
        })
        
    }
    
    func ShowError(mesage: String)  {
        dispatch_async(dispatch_get_main_queue(),{
            self.error.message = mesage
            self.error.show()
        })
        
    }
}