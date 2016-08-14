//
//  TestControllerViewController.swift
//  avaz
//
//  Created by ebad ali on 8/12/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class TestControllerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var customCollection: UICollectionView!
    
    var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: self.customCollection.frame.width-10, height: self.customCollection.frame.height-10)
        
        collectionView = UICollectionView(frame: self.customCollection.frame, collectionViewLayout: layout)
        layout.scrollDirection = .Horizontal
        collectionView!.dataSource = self
        collectionView!.delegate = self
        collectionView!.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView!.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView!)
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.blackColor()
        cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
        cell.imageView?.image = UIImage(named: "circle")
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class CollectionViewCell: UICollectionViewCell {
    var textLabel: UILabel? = UILabel()
    var imageView: UIImageView? = UIImageView()
}
