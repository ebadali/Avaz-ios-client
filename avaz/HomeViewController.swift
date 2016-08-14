//
//  HomeViewController.swift
//  avaz
//
//  Created by ebad ali on 8/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftLoader

class HomeViewController: UITableViewController, SignInDelegate,  HamburgerProtocol{
    
    
    var controllerType = ControllerType.HOME
    
    @IBOutlet weak var menuITem: UIBarButtonItem!
    var postDataSource = Array<Post>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

          self.refreshControl?.addTarget(self, action: #selector(self.handleReferesh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        self.title = "HomeViewController"
        // Do any additional setup after loading the view, typically from a nib.
        print("HomeViewController did load")
//        self.revealViewController().delegate = self;
        setupHamburger()
        print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 160.0
        


        if (UserData.sharedInstance.IsLoggedIn() ) {
            print("Lets Fetch Data")
            LoadFromRemote()
        } else{
            
            self.performSegueWithIdentifier("goto_login", sender: self)
        }
    }

    func DoneSigningIn(posts: JSON) {
        print("Got Value \(posts)")
        LoadFromLocal(posts)
    }
    
    func setupHamburger()  {
        if self.revealViewController() != nil {
            menuITem.target = self.revealViewController()
            menuITem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        UserData.sharedInstance.SetControllerType(self.controllerType)
    }
    

    
    
    func LoadData(){
        
        
        for i in 1...10 {
            postDataSource.append(Post(postid:"post-\(i)", media: Media(text: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim rem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enimrem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enimad "), title: "helloWorld  \(i) ", up: i*10 , down: i*3, loc: "Some where on planet earth", latitude: 32.4 , longitude : 64.334))
        }
        
        print(postDataSource)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dataCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! CustomCell
        let something: Post? = postDataSource[indexPath.row]
        dataCell.setData(something?.title, posterImageUrl: something?.user?.PicId as? String)
        
        //        dataCell.headingTextView.text = something?.title
        //        dataCell.customImageView!.kf_setImageWithURL(NSURL(string: (something?.tex2)!)!)
        return dataCell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_login" {
            
            if let loginViewCntroller = segue.destinationViewController as? LoginViewController{
                loginViewCntroller.signInCompletedDelegate = self
            }
        }else if segue.identifier == "postdetailsegue" {
            
            if let detail: UpdateDetailViewController = segue.destinationViewController as? UpdateDetailViewController {
                
                let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
                detail.data = self.postDataSource[(selectedIndex?.row)!]
            }
            
        }
    }
    
    
    
    func LoadFromRemote() {
        
        SwiftLoader.show(animated: true)
        ApiManager.sharedInstance.getAllPost(
            {(json : JSON) in
                SwiftLoader.hide()
                //            print(json)
                guard let posts = json["posts"].array,
                    locs = json["locations"].array,
                    users = json["users"].array,
                    medias = json["media"].array else
                {
                    // Not Found.
                    return
                }
                // being overly consious
                let Mmin = min(posts.count, min(locs.count, min(users.count, medias.count)))
                for i in 0..<Mmin {
                    //                print("\(post) - \(media) - \(loc)")
                    
                    self.postDataSource.append(Post(post: posts[i], media: medias[i], location: locs[i], user: users[i]))
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
                
        })
        
    }
    
    func LoadFromLocal(json: JSON) {
      
                guard let posts = json["posts"].array,
                    locs = json["locations"].array,
                    users = json["users"].array,
                    medias = json["media"].array else
                {
                    // Not Found.
                    return
                }
                // being overly consious
                let Mmin = min(posts.count, min(locs.count, min(users.count, medias.count)))
                for i in 0..<Mmin {
                    //                print("\(post) - \(media) - \(loc)")
                    
                    self.postDataSource.append(Post(post: posts[i], media: medias[i], location: locs[i], user: users[i]))
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.tableView.reloadData()
                })
    }
    
    
    func handleReferesh(refreshControl: UIRefreshControl)  {
        print("Handling referesh")
        
        
        let tempPost = self.postDataSource.first
        //        self.postDataSource.append(tempPost!)
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    
    
    
    
}
