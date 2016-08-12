//
//  TestView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/12/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation

class MediaSource: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {

    
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
    
    
    
    
    var mediaSource: [MediaValues] = []
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        CustomInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        
        CustomInit()
    }
    var collectionView: UICollectionView!
    
    func CustomInit()  {
    
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.bounds.width/2, height: self.bounds.height)
        layout.scrollDirection = .Horizontal
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(MediaSourceObject.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.addSubview(collectionView)
    }
    
    
    
    
    func AddMedia(named: String, mediaType: MediaType, accessType: AccessType, prevCallback : (MediaSourceObject)->() ) {
        
        
        let imgOne = MediaValues(url: named, medType: mediaType, accType: accessType, prevCallback: prevCallback)
        
//         let imgOne = MediaSourceObject(named, mediaType: mediaType, accessType: accessType)
//        imgOne.setMedia(named, medType: mediaType, accType: accessType)
//        imgOne.contentMode = .ScaleAspectFit

        
        self.mediaSource.append(imgOne)
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
