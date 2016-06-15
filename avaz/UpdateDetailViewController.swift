//
//  UpdateDetailViewController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/2/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
class UpdateDetailViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableViewRoot: UITableView!
    
    var arr1 = [{" Object -1 "}]
    var arr2 = [{" Object -1 "}]
    var data : Post!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        tableViewRoot.registerNib(UINib(nibName: "MapView", bundle: nil), forCellReuseIdentifier: "mapviewcell")
        
        tableViewRoot.registerNib(UINib(nibName: "CommentView", bundle: nil), forCellReuseIdentifier: "commentviewcell")
        
        // Self-sizing magic!
//        tableViewRoot.rowHeight = 100
        tableViewRoot.rowHeight = UITableViewAutomaticDimension
        
        tableViewRoot.estimatedRowHeight = 180.0; //Set this to any value that works for you.

        
        LoadData()
    }
    
    func LoadData() {
        
        for i in 0...10 {
            arr1.append({" Object \(i) "})
        }
        
        for i in 0...10 {
            arr2.append({" Object \(i) "})
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
            return arr2.count
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell =  VotesView(coder: self.coder)// UITableViewCell()
        
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NameInput
//        
//        var cell = (indexPath.section == 0) ? tableView.dequeueReusableCellWithIdentifier("mapviewcell", forIndexPath: indexPath) as! MapView :
//                                            tableView.dequeueReusableCellWithIdentifier("commentviewcell", forIndexPath: indexPath) as! CommentView
//        
        
        if indexPath.section == 0{
            
            // THis is Map view Along with
           let cell = tableView.dequeueReusableCellWithIdentifier("mapviewcell", forIndexPath: indexPath) as! MapView
            cell.setparams(self.data)
            
            return cell
        }
        else{
            // This will be a Comment View
           let  cell = tableView.dequeueReusableCellWithIdentifier("commentviewcell", forIndexPath: indexPath) as! CommentView
            return cell
        }

    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " "
        }else{
            return "Comments"
        }
    }
    
//    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
//        let cell = tableView.cellForRowAtIndexPath(indexPath)
//        return cell!.frame.height
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        if section == 0 {
//            return nil
//        }else{
//            let vw = UIView()
//            vw.backgroundColor = UIColor.blackColor()
//            
//            return vw
//        }
//
//    }
    
    
}


enum DetailViewTypes {
    case Map
    case Comment
}


