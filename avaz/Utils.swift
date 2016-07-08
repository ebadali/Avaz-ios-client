//
//  Utils.swift
//  avaz
//
//  Created by ebad ali on 7/7/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation


class Utils
{
//    static let sharedInstance = Utils()
//    private init() {}
    
    
    static func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}