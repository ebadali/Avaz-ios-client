//
//  MediaView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/9/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation


class MediaView: UIView, iCarouselDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource  {

    
    @IBInspectable var canupload: Bool = false {
        didSet {
            
            if self.canupload {
                
                // Will use it later
//                uploadImageView = self.AddImageToScrollView("upload")
            }

        }
    }
    
    
    var carouselViews : [CustomMediaCell]  = []
    
    var scrollView : UIScrollView = UIScrollView()
    
    lazy var scrollViewWidth:CGFloat = {
        return self.frame.width
    }()
    lazy var scrollViewHeight:CGFloat = {
        return self.frame.height
    }()
    
    

    var uploadImageView: CustomMediaCell?
    
    lazy var carousel:iCarousel = {
        var temp =  iCarousel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        
        temp.type = .Linear
        
        
        return temp
        
    }()
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return carouselViews.count
    }
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        let imageView: UIImageView
        
        if view != nil {
            imageView = view as! UIImageView
        } else {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:  self.frame.width-10, height:  self.frame.height-10))
        }
        
        
        
        imageView.image = carouselViews[index].imageView.image
//            UIImage(named: "social-media")
        
        return imageView
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addCustomView()
    }
    
    init(frame: CGRect, uploadable: Bool) {
        self.canupload = uploadable
        super.init(frame: frame)
        self.addCustomView()
    }
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        self.addCustomView()
        
    }
    
    
    func AddImageToScrollView(named: String, mediaType: MediaType, accessType: AccessType ) -> CustomMediaCell{
        
        let count = CGFloat( self.scrollView.subviews.count )
        let imgOne = CustomMediaCell(frame: CGRectMake(self.scrollViewWidth * count, 0,self.scrollViewWidth, self.scrollViewHeight) ,
                                     url: named ,mediaType: mediaType, accessType: accessType)
        
//        imgOne.contentMode = .ScaleAspectFit
        imgOne.userInteractionEnabled = true
        
        
        
        self.carouselViews.append(imgOne)
        self.carousel.reloadData()
        
        
        return imgOne
    }
    
    
    var collectionView: UICollectionView!
    
    func addCustomView() {
        
        self.userInteractionEnabled = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 20, height: 20)
        
        self.collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView.backgroundColor = UIColor.whiteColor()
        self.addSubview(collectionView)
        
        
        
//        self.AddImageToScrollView("social-media", mediaType: MediaType.Image(), accessType:  AccessType.Local())
//        self.AddImageToScrollView("social-media", mediaType: MediaType.Image(), accessType:  AccessType.Local())
        
//      Add Layout Margins.
//      Add Layout Spacing.
        
//        self.carousel.centerItemWhenSelected = true
//        self.carousel.dataSource = self
//        self.addSubview(self.carousel)
        
        

//        self.AddImageToScrollView("social-media", mediaType: MediaType.Image(), accessType:  AccessType.Local())
    }
    
    
//    func AddRemoteMedia(url: String, type: MediaType) -> CustomMediaCell {
//        
//    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.orangeColor()
        return cell
    }
    
    func RemoveThisMediaCell(image: CustomMediaCell)  {
        //        print("try to this \(image.tag)")
        // Do indexing
        
        //FIXME: Move back all the cells by recalculating their positions.
        
        var found = false;
        var counter = 0
        for subview in self.scrollView.subviews  {
            //            print("Removing this \(subview.tag)")
            
            if found {
                subview.frame.origin.x = (subview.frame.origin.x-image.frame.width)
                counter += 1
            }
            else if subview.tag == image.tag {
                subview.removeFromSuperview()
                found = true
            }
            
        }
    }
    
    
    
}











