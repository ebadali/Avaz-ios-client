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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")
        // Do any additional setup after loading the view.

        // Adding Comment View
        
        
        tableViewRoot.registerNib(UINib(nibName: "MapView", bundle: nil), forCellReuseIdentifier: "mapviewcell")
        
        tableViewRoot.registerNib(UINib(nibName: "CommentView", bundle: nil), forCellReuseIdentifier: "commentviewcell")
        
        // Self-sizing magic!
//        tableViewRoot.rowHeight = 100
        tableViewRoot.rowHeight = UITableViewAutomaticDimension
        
        tableViewRoot.estimatedRowHeight = 180.0; //Set this to any value that works for you.

        
        LoadData()
        
        
        self.view.addSubview(self.button)
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
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
        return UITableViewAutomaticDimension
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
            guard let Comment = firstTextField.text where firstTextField.text != "" else{
                return
            }
            
            print(Comment)
            
            self.arr2.append({Comment})
            
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

//        let deletedString = ""
//        
//        func wordEntered(alert: UIAlertAction!){
//            // store the new word
//            self.newWordField!.text = deletedString + " " + self.newWordField!.text!
//            
//            print("wordEntered \(self.newWordField!.text) ")
//        }
//        func addTextField(textField: UITextField!){
//            // add the text field and make the result global
//            textField.placeholder = "Definition"
//            self.newWordField = textField
//            
//            print("addTextField  \(self.newWordField!.text)")
//        }
//        
//        // display an alert
//        let newWordPrompt = UIAlertController(title: "Enter definition", message: "Trainging the machine!", preferredStyle: UIAlertControllerStyle.Alert)
//        newWordPrompt.addTextFieldWithConfigurationHandler(addTextField)
//        newWordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
//        newWordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: wordEntered))
//        presentViewController(newWordPrompt, animated: true, completion: nil)
        
        
//        alertController.addAction(gallery)
//        alertController.addAction(camera)
//        
//        self.presentViewController(alertController, animated: true, completion:{
//            alertController.view.superview?.userInteractionEnabled = true
//            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
//        })

    }
    
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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


