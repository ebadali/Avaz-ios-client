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
            someDataSource.append(Post(text1: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad ", text2: "yolo  \(i) ", up: i*10 , down: i*3 ))
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
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_UTILITY.rawValue),0))
        {
            
            
            let url = NSURL(string: "http://jsonplaceholder.typicode.com/photos")
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    for blog in (json as? [[String: AnyObject]])!{
                        
                        let dat = Post(text1: "",text2: "",up: 5, down: 7)
                        if let title = blog["title"] as? String  {
                            dat.tex1 = title
                        }
                        if let thumbnailUrl = blog["thumbnailUrl"] as? String  {
                            dat.tex2 = thumbnailUrl
                        }
                        
                        self.someDataSource.append(dat)
                    }
                    
                } catch {
                    print("error serializing JSON: \(error)")
                }
                
                print(response)
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //reload your tableView
                    self.tableView.reloadData()
                })
            }
            task.resume()
            
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }

    
}