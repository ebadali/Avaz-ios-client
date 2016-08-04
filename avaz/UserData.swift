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

class UserData{
    
    static let sharedInstance = UserData()
    var sessionId: String?
    var currentUser: User?
    let defaults:NSUserDefaults

    private init() {
        defaults = NSUserDefaults.standardUserDefaults()

        
        if let userObject = defaults.objectForKey(Keys.USER_OBJECT.rawValue) as? User,
                sessionValue = defaults.stringForKey(Keys.USER_OBJECT.rawValue)
        
        {
            self.currentUser = userObject
            self.sessionId = sessionValue
        }
        else
        {
            self.currentUser = nil
            self.sessionId = ""

        }
        
        
        
    }
    
    func SetCurrentUser(data: JSON)  {

        // Todo: This should be Atomic.
        self.currentUser = User(json: data)
        defaults.setObject(self.currentUser, forKey: Keys.USER_OBJECT.rawValue)
    }
    
    func SetSessionID(data: String)  {
        self.sessionId = data
        defaults.setObject(self.sessionId, forKey: Keys.SESSION_ID.rawValue)
    }
    
    
    func GetCurrentUser()  -> User{
        
        if self.currentUser == nil
        {
            self.currentUser  = defaults.objectForKey(Keys.USER_OBJECT.rawValue) as? User
        }
        return self.currentUser!
    }
    
    func GetSessionID() -> String  {
        if self.sessionId == ""
        {
            self.sessionId  = defaults.stringForKey(Keys.USER_OBJECT.rawValue)
        }
//        return self.sessionId!
        return ""
    }
    
    
    
    
}