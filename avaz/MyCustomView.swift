//
//  MediaView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/9/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation

class MediaView: UIView , UICollectionViewDataSource, UICollectionViewDelegate{

    
    @IBInspectable var canupload: Bool = false {
        didSet {
            
            if self.canupload {
                
                // Will use it later
//                uploadImageView = self.AddImageToScrollView("upload")
            }

        }
    }
    
    
//    var scrollView : UIScrollView = UIScrollView()

//    
    var scrollView: UICollectionView!
    
    
    lazy var scrollViewWidth:CGFloat = {
        return self.frame.width
    }()
    lazy var scrollViewHeight:CGFloat = {
        return self.frame.height
    }()
    
    

    var uploadImageView: CustomMediaCell?
    
    
    
    override init(frame: CGRect) {
                print("init without bool")
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: frame.width-20 , height: frame.height-20)
        layout.scrollDirection = .Horizontal
        scrollView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
       
        scrollView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        scrollView.backgroundColor = UIColor.whiteColor()
        

        
        super.init(frame: frame)

        
        self.addCustomView()
    }
    
    init(frame: CGRect, uploadable: Bool) {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: frame.width-20 , height: frame.height-20)
        layout.scrollDirection = .Horizontal
        scrollView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        
        scrollView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        scrollView.backgroundColor = UIColor.whiteColor()

//        self.scrollView.frame = CGRectMake(0, 0, frame.width, frame.height)
        print("init with bool")
        
        self.canupload = uploadable
      
        
        super.init(frame: frame)
        
        
        self.addCustomView()
        
    }
    required init(coder aDecoder: NSCoder) {
        
      
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake(100, 100)
        scrollView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        
        scrollView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        scrollView.backgroundColor = UIColor.whiteColor()

        
        super.init(coder: aDecoder)!
        self.addCustomView()
        
    }
    
    
    func AddImageToScrollView(named: String, mediaType: MediaType, accessType: AccessType ) -> CustomMediaCell{
        
        let count = CGFloat( self.scrollView.subviews.count )
        print("AddImageToScrollView \(count) ")
//        let imgOne = CustomMediaCell(frame: CGRectMake(self.scrollViewWidth * count, 0,self.scrollViewWidth, self.scrollViewHeight) ,
//                                     url: named ,mediaType: MediaType.Image(), accessType: AccessType.Local())
//
//        imgOne.contentMode = .ScaleAspectFit
//        imgOne.userInteractionEnabled = true
//        
//        self.scrollView.addSubview(imgOne)//(iv, atIndex: endIndexx+1)
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * (count+1), self.scrollView.frame.height)
//        
        
        
        let imgOne = CustomMediaCell(frame: CGRectMake(self.scrollViewWidth * count, 0,self.scrollViewWidth, self.scrollViewHeight) ,
                                     url: named ,mediaType: mediaType, accessType: accessType)
        
        imgOne.contentMode = .ScaleAspectFit
        imgOne.userInteractionEnabled = true
          self.scrollView.addSubview(imgOne)
//        self.scrollView.insertSubview(imgOne, atIndex: Int(count+1))
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * (count+1), self.scrollView.frame.height)
        
        return imgOne
    }
    
    func addCustomView() {

        scrollView.dataSource = self
        scrollView.delegate = self
        
        self.addSubview(self.scrollView)
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
        cell.imageView?.image = UIImage(named: "circle")
        return cell
    }
    
//    func AddRemoteMedia(url: String, type: MediaType) -> CustomMediaCell {
//        
//    }
    
    
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











