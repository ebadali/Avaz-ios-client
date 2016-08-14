//
//  TestView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/12/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation

class MediaSource: UIView, UICollectionViewDelegate, UICollectionViewDataSource  {

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaSource.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! MediaSourceObject
//        cell.backgroundColor = UIColor.orangeColor()
        let medValues : MediaValues = mediaSource[indexPath.item]
        cell.setMedia(medValues.url, medType: medValues.mediaType, accType: medValues.accessType, prevCallback: medValues.previewCallback )
        cell.load()
        return cell
    }
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var mediaSource: [MediaValues] = []
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        
        xibSetup()
    }
    var view: UIView!
    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = bounds
        
        // Make the view stretch with containing view
        view.autoresizingMask = UIViewAutoresizing.FlexibleWidth.union(UIViewAutoresizing.FlexibleHeight)
//        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "MediaSource", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        self.collectionView.registerClass(MediaSourceObject.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        return view
    }

    
    
    
    func AddMedia(named: String, mediaType: MediaType, accessType: AccessType, prevCallback : (MediaSourceObject)->() ) {
        
        
        let imgOne = MediaValues(url: named, medType: mediaType, accType: accessType, prevCallback: prevCallback)
        
//         let imgOne = MediaSourceObject(named, mediaType: mediaType, accessType: accessType)
//        imgOne.setMedia(named, medType: mediaType, accType: accessType)
//        imgOne.contentMode = .ScaleAspectFit

        
        self.mediaSource.append(imgOne)
        self.collectionView.reloadData()
      
    }
    
    
    
    
    func Remove(url: String) {
        self.mediaSource = self.mediaSource.filter(){$0.url != url}
        
        self.collectionView.reloadData()
    }
}

class MediaValues
{
    var url:String = ""
    var mediaType: MediaType = .Image()
    var accessType: AccessType = .Local()
    
    var cancleCallback = {}
    var previewCallback: (MediaSourceObject)->() = {_ in }
    
    init(url: String ,medType: MediaType, accType: AccessType, prevCallback : (MediaSourceObject)->())
    {
        self.url  = url
        self.mediaType = medType
        self.accessType = accType
        self.previewCallback = prevCallback
    }

}
