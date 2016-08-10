//
//  UpdateDetailViewController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/2/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVKit
import AVFoundation
class UpdateDetailViewController: UIViewController, UITableViewDataSource , PreviewDelegate{

//    lazy var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(self.handleReferesh(_:)), forControlEvents: UIControlEvents.ValueChanged)
//        
//        return refreshControl
//    }()

    
    @IBOutlet weak var tableViewRoot: UITableView!
    
    var arr1 = [{" Object -1 "}]
    var comments = [Comment]()
    
    var data : Post!
    
    
    let someHeight: CGFloat = 80
    
    lazy var button: UIButton = {
        let button = UIButton()
        let butnHeight: CGFloat = 40, butnWidth: CGFloat = 40
        button.frame = CGRect(origin: CGPoint(x: self.view.frame.width-(butnWidth*1.5), y: self.view.frame.size.height-(butnHeight*1.5)), size: CGSize(width: butnWidth ,  height: butnHeight))
        ////        button.frame = CGRect(origin: CGPoint(x: self.view.frame.width-(butnWidth*1.5), y: self.view.frame.size.height-(butnHeight*1.5)), size: CGSize(width: butnWidth ,  height: butnHeight))
        //        //        CGSize {return CGSizeMake(self.view.frame.width , 200)}
        //        button.backgroundColor = UIColor.blackColor()
        //        button.alpha = 0.5
        button.setImage(UIImage(named: "create_message"), forState: .Normal)
//        button.contentMode = .ScaleToFill;
        button.addTarget(self, action:  #selector(self.WriteAComment), forControlEvents: .TouchUpInside)
            return button
    }()
    
    
    
    // Creating Filter
    lazy var filter: UIView = {
        
        let filter = UIView()
        filter.frame = CGRect(origin: CGPoint(x: self.view.frame.origin.x, y: self.view.frame.size.height-self.someHeight), size: CGSize(width: self.view.frame.width ,  height: self.someHeight))
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.5
        return filter
    }()

    var mapViewHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")
        // Do any additional setup after loading the view.

        // Adding Comment View
        

        self.tableViewRoot.registerNib(UINib(nibName: "MapView", bundle: nil), forCellReuseIdentifier: "mapviewcell")
        
        self.tableViewRoot.registerNib(UINib(nibName: "CommentView", bundle: nil), forCellReuseIdentifier: "commentviewcell")
        
        mapViewHeight = NSBundle.mainBundle().loadNibNamed("MapView", owner: self, options: nil)[0].bounds.size.height


    
        
//        LoadData()
        LoadRemoteData()
        
//        self.view.addSubview(self.refreshControl)
        self.view.addSubview(self.button)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
    }
    
    
    func LoadRemoteData()  {
        
        
        
        ApiManager.sharedInstance.getAllComments(data.postID,
            onCompletion: {(json : JSON) in
//                print("All Commments are - \(json)")
                
                guard let mediaobj = json["media"].array,
                          commenters = json["users"].array
                    else
                {
                    // Not Found.
                    return
                }
                
                let counter = min(mediaobj.count,commenters.count)
                for i in 0..<counter
                {
                    self.comments.append( Comment(mediaJson: mediaobj[i], userJson: commenters[i]) )
                }
                
                
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableViewRoot.reloadData()
                })
                
        })

    }
    
    func LoadData() {
        
        for i in 0...10 {
            arr1.append({" Object \(i) "})
        }
        
        for i in 0...10 {
            comments.append(Comment(text: " ashjgsajhd sadashjdg ajsdjasd ajshgd sdg asjdga sdajgsdjhagd adjhgajhdg jhasgdasd akjsdh akhashjgsajhd sadashjdg ajsdjasd ajshgd sdg asjdga sdajgsdjhagd adjhgajhdg jhasgdasd akjsdh akh \(i) "))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ovveriding methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // Beacuse the Upper Section
            return 1
        }
        else{
            // Cooment View Count.
            return comments.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    
  
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        
        if indexPath.section == DetailViewTypes.Map.rawValue{
            
            // THis is Map view Along with
           let cell = tableView.dequeueReusableCellWithIdentifier("mapviewcell", forIndexPath: indexPath) as! MapView
            cell.setparams(self.data, callback: self)
            return cell
        }
        else{
            // This will be a Comment View
            let  cell = tableView.dequeueReusableCellWithIdentifier("commentviewcell", forIndexPath: indexPath) as! CommentView
//            cell.commenterText.text = comments[indexPath.row]
//            cell.commenterImage.image = LoadImage(comments[])
//            print("index is \(indexPath.row)")
            cell.setData(comments[indexPath.row].media.content, posterImageUrl: comments[indexPath.row].user.PicId as String)
            return cell
        }

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Post"
        }else{
            return "Comments"
        }
    }
    
//    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        return cell!.frame.height
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        

        return indexPath.section == 0  ? mapViewHeight : UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
    @IBOutlet var newWordField: UITextField?

    
    func WriteAComment(sender: AnyObject)  {

        
        let alertController = UIAlertController(title: "Add A Comment", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            guard let CommentText = firstTextField.text where firstTextField.text != "" else{
                return
            }
            
            print(CommentText)
            
            self.comments.append(Comment(text: CommentText))
//            print("data added")

            
            
            self.tableViewRoot.beginUpdates()
//            self.comments.count-1
            self.tableViewRoot.insertRowsAtIndexPaths([
                NSIndexPath(forRow: 0, inSection: DetailViewTypes.Comment.rawValue)
                ], withRowAnimation: .Automatic)
            self.tableViewRoot.endUpdates()

            
            self.sendThisComment(Comment(text: CommentText))

            
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Your Comment"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)


    }
    
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func sendThisComment(cmnt: Comment)  {
        ApiManager.sharedInstance.insertAComment(data.postID, comment: cmnt,
                                            
            onCompletion: {(json : JSON) in
                print("All Commments are - \(json)")
        })
    }
    
    
    
    func handleReferesh(refreshControl: UIRefreshControl)  {
        print("Handling referesh")
        
        
        let tempPost = self.comments.first
        //        self.someDataSource.append(tempPost!)
        
        self.tableViewRoot.reloadData()
        refreshControl.endRefreshing()
    }

    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        let mpView = NSBundle.mainBundle().loadNibNamed("MapView", owner: self, options: nil)[0] as? MapView
        mpView?.removeFromSuperview()
//        mapView.removeFromSuperview()
    }
    
    
    func OutFromLargeView(sender: UITapGestureRecognizer)  {
        sender.view?.removeFromSuperview()
    }
    
    
    func PreviewImage(mediaObject : CustomMediaCell){
        print("Lets Display someVideo")
        
        let newImageView = UIImageView(image: mediaObject.imageView.image)
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.OutFromLargeView(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    func PreviewVideo(mediaObject : CustomMediaCell){
        print("Lets Display someImage")
        
        let playerViewController = AVPlayerViewController()
        let playerView = AVPlayer(URL: NSURL(fileURLWithPath: mediaObject.url))
        playerViewController.player = playerView
        
        self.presentViewController(playerViewController, animated: true){
            playerViewController.player?.play()
        }
    }
    
}


enum DetailViewTypes : Int{
    case Map = 0
    case Comment = 1
}


