//
//  UserData.swift
//  avaz
//
//  Created by Nerdiacs Mac on 7/28/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import SwiftyJSON


enum Keys: String {
    case USER_OBJECT = "user_object";
    case SESSION_ID  = "session_id" ;
}


enum ControllerType : String{
    case HOME = "home";
    case POST = "post";
    case HISTORY = "history";
    case LOGOUT = "logout";
}

class UserData{
    
    static let sharedInstance = UserData()
    var sessionId: String?
    var currentUser: User?
    let defaults:NSUserDefaults
    
    var currentControllerType : ControllerType = .HOME
    
    private init() {
        defaults = NSUserDefaults.standardUserDefaults()

        
        if let userObject = defaults.objectForKey(Keys.USER_OBJECT.rawValue),
                sessionValue = defaults.stringForKey(Keys.USER_OBJECT.rawValue)
        
        {
            
            self.currentUser = NSKeyedUnarchiver.unarchiveObjectWithData(userObject as! NSData) as? User
            self.sessionId = sessionValue
        }
        else
        {
            self.currentUser = nil
            self.sessionId = ""

        }
        
        
        
    }
    
    func IsLoggedIn() -> Bool {

        return self.sessionId != ""
    }
    
    func SetCurrentUser(data: JSON)  {

        // Todo: This should be Atomic.
        self.currentUser = User(json: data)
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(self.currentUser!)
        defaults.setObject(encodedData, forKey: Keys.USER_OBJECT.rawValue)
        defaults.synchronize()
    }
    
    func SetSessionID(data: String)  {
        self.sessionId = data
        defaults.setObject(self.sessionId, forKey: Keys.SESSION_ID.rawValue)
    }
    
    
//    func GetCurrentUser()  -> User{
//        
//        if self.currentUser == nil
//        {
//            
//            let userObject  = defaults.objectForKey(Keys.USER_OBJECT.rawValue)
//            self.currentUser = NSKeyedUnarchiver.unarchiveObjectWithData(userObject as! NSData) as? User
//            
//        }
//        return self.currentUser!
//    }
//    
//    func GetSessionID() -> String  {
//        if self.sessionId == ""
//        {
//            self.sessionId  = defaults.stringForKey(Keys.USER_OBJECT.rawValue)
//        }
//        return self.sessionId!
//
//    }
    
    
    func SetControllerType(type: ControllerType)  {
        self.currentControllerType = type
    }
    func GetControllerType() -> ControllerType {
        return self.currentControllerType
    }
    
    func ClearAll()  {
        
        
        defaults.removeObjectForKey(Keys.SESSION_ID.rawValue)
        defaults.removeObjectForKey(Keys.USER_OBJECT.rawValue)
        
        currentUser = nil
        sessionId = ""
        
        
        SetSessionID("")
        self.currentUser = nil
        SetCurrentUser(nil)
        
        
        let appDomain = NSBundle.mainBundle().bundleIdentifier!
        
        NSUserDefaults.standardUserDefaults().removePersistentDomainForName(appDomain)
        
    }
    
    
    
}