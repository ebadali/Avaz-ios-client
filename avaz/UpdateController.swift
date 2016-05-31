//
//  UpdateController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//


import UIKit

class UpdateController: UITableViewController {
    
    var someDataSource = Array<Post>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LoadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func LoadData(){
        for i in 1...10 {
            someDataSource.append(Post(text1: "hello world \(i)", text2: "yolo  \(i) ", up: i*10 , down: i*3 ))
        }
        
        print(someDataSource)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return someDataSource.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let dataCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath) as! CustomCell
        let something: Post? = someDataSource[indexPath.row]
        dataCell.headingTextView.text = something?.tex1
//        dataCell.textKiDosriJaga.text = something?.tex2
//        print(dataCell.textKiJaga.text)
        print(dataCell.headingTextView.text )
        //        dataCell.customImageView!.kf_setImageWithURL(NSURL(string: (something?.tex2)!)!)
        return dataCell
    }
    
}