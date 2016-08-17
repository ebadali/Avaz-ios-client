//
//  ImageViewExtension.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//
import UIKit
import AVFoundation

let imageCache = NSCache()

extension UIImageView{
    
    
    
    //    ------------------ Handles All type of media ( image and video ) and Their Compression ----------
    
    func loadmedia(url: String, mediatype: MediaType, accessType: AccessType)  {
        
        switch mediatype {
        case MediaType.Image():
            loadImage(url,accessType: accessType)
        case MediaType.Video():
            loadVideo(url, accessType: accessType)
            
        }
    }
    
    
    func loadVideo(url: String,accessType: AccessType)  {
        switch accessType {
        case AccessType.Local():
            loadVideoLocally(url)
        case AccessType.Remote():
            loadVideoRemotely(url)
        }
    }
    func loadImage(url: String,accessType: AccessType)  {
        switch accessType {
        case AccessType.Local():
            loadImageLocally(url)
        case AccessType.Remote():
            loadImageRemotely(url)
        }
    }
    
    
    
    //    Everything is with cahce
    
    func loadImageLocally(urlString: String)  {
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            
            self.clipsToBounds = true
            self.image = cachedImage
            Animate()
        }
        else if let loadedImage = UIImage(named: urlString) {
            
            self.image = UIImage(data: UIImageJPEGRepresentation(loadedImage, 0.1)!)
            imageCache.setObject(self.image!, forKey: urlString)
        }
    }
    
    
    
    func loadImageRemotely(urlString: String)  {
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            
            dispatch_async(dispatch_get_main_queue(), {
                self.clipsToBounds = true
                self.image = cachedImage
                self.Animate()
            })
            return
        }
        
        let encodedPath = urlString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let finalurl = "http://dev.nerdiacs.com:8001/media/getmedia?url=\(encodedPath)"
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
                    
                    self.image = UIImage(data: UIImageJPEGRepresentation(downloadedImage, 0.1)!)
                    self.clipsToBounds = true
                    imageCache.setObject(self.image!, forKey: urlString)
                    
                    
                    self.alpha = 0
                    UIView.animateWithDuration(0.98, animations: { () -> Void in
                        self.alpha = 1
                    })
                }
            })
            
        }).resume()
    }
    
    
    
    func loadVideoRemotely(urlString: String)  {
        // To Implement
    }
    func loadVideoLocally(urlString: String)  {
        
        if let cachedImage = imageCache.objectForKey(urlString) as? UIImage {
            self.clipsToBounds = true
            self.image = cachedImage
            Animate()
            
            
        }else{
            do {
                print("compressing video frame")
                let asset = AVURLAsset(URL: NSURL(fileURLWithPath: urlString), options: nil)
                let imgGenerator = AVAssetImageGenerator(asset: asset)
                imgGenerator.appliesPreferredTrackTransform = true
                let cgImage = try imgGenerator.copyCGImageAtTime(CMTimeMake(0, 1), actualTime: nil)
                
                if let loadedImage: UIImage = UIImage(CGImage: cgImage) {
                    // Set Compress Data
                    self.clipsToBounds = true
                    self.image = UIImage(data: UIImageJPEGRepresentation(loadedImage, 0.1)!)
                    imageCache.setObject(self.image!, forKey: urlString)
                }
            } catch let error as NSError {
                print("Error generating thumbnail: \(error)")
            }
            
        }
    }
    
    func Animate()  {
        
        self.alpha = 0
        
        UIView.animateWithDuration(0.98, animations: { () -> Void in
            self.alpha = 1
            
        })
    }
}