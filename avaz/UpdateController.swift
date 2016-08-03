//
//  UpdateController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//


import UIKit
import SwiftyJSON

class UpdateController: UITableViewController, HamburgerProtocol {
    
    @IBOutlet weak var menuItem: UIBarButtonItem!
    var someDataSource = Array<Post>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
                print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        
        setupHamburger()
        LoadFromRemote()
        
        
//        LoadData()
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
    }
    func setupHamburger() {
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoadData(){
        
        
        for i in 1...10 {
            someDataSource.append(Post(postid:"post-\(i)", details: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim rem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enimrem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enimad ", title: "helloWorld  \(i) ", up: i*10 , down: i*3, loc: "Some where on planet earth", latitude: 32.4 , longitude : 64.334))
        }
        
        print(someDataSource)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someDataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dataCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! CustomCell
        let something: Post? = someDataSource[indexPath.row]
        dataCell.headingTextView.text = something?.title
        //        dataCell.customImageView!.kf_setImageWithURL(NSURL(string: (something?.tex2)!)!)
        return dataCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pop_over" {
            
            //            if let fourthSeq: ScreenFour = segue.destinationViewController as? ScreenFour{
            //                let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
            //                fourthSeq.data = self.someDataSource[(selectedIndex?.row)!]
            //            }
        }else{
            
            if let detail: UpdateDetailViewController = segue.destinationViewController as? UpdateDetailViewController {
                
                let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
                detail.data = self.someDataSource[(selectedIndex?.row)!]
            }
            
        }
    }


    
    func LoadFromRemote() {
        
        
        ApiManager.sharedInstance.getAllPost(
        {(json : JSON) in
//            print(json)
            guard let posts = json["posts"].array,
                      locs = json["locations"].array,
                      medias = json["media"].array else
            {
                // Not Found.
                return
            }
            // being overly consious
            let Mmin = min(posts.count, min(locs.count, medias.count))
            for i in 0..<Mmin {
//                print("\(post) - \(media) - \(loc)")
                
                self.someDataSource.append(Post(post: posts[i], media: medias[i], location: locs[i]))
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                                    self.tableView.reloadData()
                                })
            
        })
        
        
//        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue),0))
//        {
//        ApiManager.sharedInstance.getRandomPost(
//            {(json : JSON) in
//                print ("-----")
//                //                print (json.array)
//                //                                print ("-----1")
//                //                print (json[0][0])
//                //                                print ("-----2")
//                if let results = json.array {
//                    for somePosts in results {
//                        //                        print (somePosts["Post"])
//                        self.someDataSource.append(Post(json: somePosts["Post"]))
//                    }
//                    dispatch_async(dispatch_get_main_queue(),{
//                        self.tableView.reloadData()
//                    })
//                }
//                
//            }
//        )
//        }

    }
}
