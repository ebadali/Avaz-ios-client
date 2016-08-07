//
//  ImageViewExtension.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//
import UIKit

let imageCache = NSCache()
extension UIImageView{
    
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        
        let finalurl = "http://localhost:8001/media/getmedia?url=\(urlString)"
        //otherwise fire off a new download
        let url = NSURL(string: finalurl)
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if error != nil {
                print(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString)
                    
                    self.image = downloadedImage
                    
                    self.alpha = 0
                    UIView.animateWithDuration(0.25, animations: { () -> Void in
                        self.alpha = 1
                    })
                }
            })
            
        }).resume()
    }
    
}