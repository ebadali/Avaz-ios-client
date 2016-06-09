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
        
        // Self-sizing magic!
        tableViewRoot.rowHeight = UITableViewAutomaticDimension
        tableViewRoot.estimatedRowHeight = 150; //Set this to any value that works for you.

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
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0{
            
            // THis is Map view Along with
            cell = tableView.dequeueReusableCellWithIdentifier("mapviewcell", forIndexPath: indexPath) as! MapView
            
            
        }
        else{
            // This will be a Comment View
            cell =  UITableViewCell()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return " "
        }else{
            return "Details"
        }
    }
    
    
    
}


enum DetailViewTypes {
    case Map
    case Comment
}


