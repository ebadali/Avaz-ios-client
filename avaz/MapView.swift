//
//  MapView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/3/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import MapKit

class MapView: UITableViewCell {
    
    @IBOutlet weak var icon_imageView: UIImageView!
    @IBOutlet weak var detail_TextView: UILabel!
    @IBOutlet weak var map_MKView: MKMapView!
    @IBOutlet weak var loc_TextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        print("awake from nib")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func setparams(post: Post) {
        
        print(self.map_MKView.annotations.count)
        if self.map_MKView.annotations.count == 0 {
        
            self.detail_TextView.text =  post.title
            self.loc_TextView.text = post.loc

            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue),0))
            {
                
                let initialLocation = CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444)
                self.centerMapOnLocation(initialLocation);
                
                let artwork = Pointer(title: "Event Occure",
                                      locationName: post.loc,
                                      discipline: "Event",
                                      location: initialLocation)
                

                dispatch_async(dispatch_get_main_queue(),{
                     self.map_MKView.addAnnotation(artwork)
                })
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
