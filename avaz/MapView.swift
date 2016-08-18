//
//  MapView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/3/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import MapKit



let mapCache = NSCache()

class MapView: UITableViewCell {
    
    @IBOutlet weak var icon_imageView: UIImageView!
    @IBOutlet weak var detail_TextView: UILabel!
    @IBOutlet weak var map_MKView: MKMapView!
    @IBOutlet weak var loc_TextView: UILabel!
    @IBOutlet weak var postedBy: UILabel!
    
    @IBOutlet weak var segmentControll: UISegmentedControl!
    
    
    @IBOutlet weak var mediaView: MediaSource!
//    mediaView
    
    var currentPost: Post? = nil
    
    var previewCallback :PreviewDelegate?

    lazy var prevCall: (MediaSourceObject)->() =
        { value in
            print("prevCallback Called \(value.cscore)")
            print("preview Called")
            if case .Video() = value.mediaType {
                self.previewCallback?.PreviewVideo(value)
            }else if  case .Image() = value.mediaType {
                self.previewCallback?.PreviewImage(value)
            }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.mediaView.hidden = true
    }
    
    var LoadedPostData = false
    func LoadPostMedia() {
        
        if  LoadedPostData == false
        {
            print(" **********  ")
            for img in (currentPost?.media?.images)!
            {
                print(img)
                self.mediaView?.AddMedia(img, mediaType: MediaType.Image(), accessType: AccessType.Remote(), prevCallback: prevCall)
                
            }
            
            
            for vid in (currentPost?.media?.videos)!
            {
                print(vid)
                self.mediaView?.AddMedia(vid, mediaType: MediaType.Video(), accessType: AccessType.Remote(), prevCallback: prevCall)
                
            }
            
            
            self.mediaView?.AddMedia("social-media", mediaType: MediaType.Image(), accessType: AccessType.Local(), prevCallback: prevCall)
            self.mediaView?.AddMedia("social-media", mediaType: MediaType.Image(), accessType: AccessType.Local(), prevCallback: prevCall)
            
            
            LoadedPostData = true
            
        }
        
    }
    
    
    @IBAction func viewChanged(sender: UISegmentedControl) {
        
        switch segmentControll.selectedSegmentIndex
        {
        case 0:
            toggleViews(true)
        case 1:
            toggleViews(false)
        default:
            break;
        }
        
        LoadPostMedia()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func toggleViews(value: Bool)  {
        
        self.map_MKView.hidden = !value
        self.mediaView.hidden = value
        
        
    }
    
    
    
    func setparams(post: Post, callback: PreviewDelegate) {
        
        if self.currentPost != nil
        {
            return
        }
        
        self.previewCallback = callback
        self.currentPost = post
        self.detail_TextView.text = post.title
        self.icon_imageView.loadImageRemotely((post.user?.PicId as? String)!)
        
        
        if self.map_MKView.annotations.count == 0 {
            
            self.postedBy.text =  post.user?.UserName as? String
            
            
            
            let lc  = "\(post.lat),\(post.lng)"
            
            if let artwork = mapCache.objectForKey(lc) as? Pointer {
                
                                self.centerMapOnLocation(artwork.coordinate);
                                dispatch_async(dispatch_get_main_queue(),{
                                    self.map_MKView.addAnnotation(artwork)
                                })
            }else{
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue),0))
                {
                    let initialLocation = CLLocationCoordinate2D(latitude: post.lat, longitude: post.lng)
                    
                    let artwork = Pointer(title: "Event Occure",
                                          locationName: post.loc,
                                          discipline: "Event",
                                          location: initialLocation)
                                    self.centerMapOnLocation(initialLocation);
                    mapCache.setObject(artwork , forKey: lc)
                                    dispatch_async(dispatch_get_main_queue(),{
                                         self.map_MKView.addAnnotation(artwork)
                                    })
                }
            }
        }
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        self.map_MKView.setRegion(coordinateRegion, animated: true)
        
        
    }
    
}
