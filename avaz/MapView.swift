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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setparams(post: Post) {
        self.detail_TextView.text =  post.detail
        self.loc_TextView.text = post.loc
        
        
        
        let initialLocation = CLLocationCoordinate2D(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(initialLocation);
        
        let artwork = Pointer(title: "Event Occure",
                              locationName: post.loc,
                              discipline: "Event",
                              location: initialLocation)
        
        self.map_MKView.addAnnotation(artwork)
        
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        self.map_MKView.setRegion(coordinateRegion, animated: true)
    }

}
