//
//  UserData.swift
//  avaz
//
//  Created by Nerdiacs Mac on 7/28/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import SwiftyJSON


class UserData{
    
    static let sharedInstance = UserData()
    var sessionId: String
    var currentUser: User?
    
    private init() {
        self.sessionId = ""
        self.currentUser = nil
    }
    
    func SetCurrentUser(data: JSON)  {
        self.currentUser = User(json: data)
    }
    
    func SetSessionID(data: String)  {
        self.sessionId = data
    }
    
    
    func GetCurrentUser()  -> User{
        return self.currentUser!
    }
    
    func GetSessionID() -> String  {
        return self.sessionId
    }
    
    
    
    
}