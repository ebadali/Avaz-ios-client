//
//  LoginViewController.swift
//  avaz
//
//  Created by ebad ali on 6/20/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizerLabel();
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pop_over" {
            
            //            if let fourthSeq: ScreenFour = segue.destinationViewController as? ScreenFour{
            //                let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
            //                fourthSeq.data = self.someDataSource[(selectedIndex?.row)!]
            //            }
        }else{
            
//            if let detail: UpdateDetailViewController = segue.destinationViewController as? UpdateDetailViewController {
//                
//                let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
//                detail.data = self.someDataSource[(selectedIndex?.row)!]
//            }
            
        }
    }
 

    @IBAction func logIn(sender: AnyObject) {
        print("logging in")
        
        print (" \(self.email.text)")
        print (" \(self.password.text)")
        
        ApiManager.sharedInstance.LogInApi(self.email.text!, password: self.password.text!,
           onCompletion: {(json : JSON) in
            
            }
        )
    }
    @IBAction func saveChanged(sender: AnyObject) {
    }
    
    func addGestureRecognizerLabel(){
        //Create a instance, in this case I used UITapGestureRecognizer,
        //in the docs you can see all kinds of gestures
        let gestureRecognizer = UITapGestureRecognizer()
        
        //Gesture configuration
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        /*Add the target (You can use UITapGestureRecognizer's init() for this)
         This method receives two arguments, a target(in this case is my ViewController)
         and the callback, or function that you want to invoke when the user tap it view)*/
        gestureRecognizer.addTarget(self, action: #selector(LoginViewController.showDatePicker))
        
        //Add this gesture to your view, and "turn on" user interaction
        register.addGestureRecognizer(gestureRecognizer)
        register.userInteractionEnabled = true
    }
    //How you can see, this function is my "callback"
    func showDatePicker(){
        //Your code here
        print("Hi, was clicked")
                 self.performSegueWithIdentifier("Refister_view_segue", sender: self)
    }
}
