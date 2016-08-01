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
    
//    save Image To Directory and returns the Path.
    static func SaveImageToDirectory(image: UIImage) -> String {
        
        if let data = UIImageJPEGRepresentation(image, 0.2) {
            
            let filename = Utils.getDocumentsDirectory().stringByAppendingPathComponent("\(Utils.getRandomName()).jpg")
            data.writeToFile(filename, atomically: true)
            
            return filename
        }
        
        return ""
        
    }
    
    
    static func getRandomName() -> String {
        return String.random()

    }
}

extension String
{
    static func random(length: Int = 10) -> String {
        
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.startIndex.advancedBy(Int(randomValue))])"
        }
        
        return randomString
    }

}