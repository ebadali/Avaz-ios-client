//
//  LoginViewController.swift
//  avaz
//
//  Created by ebad ali on 6/20/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, HamburgerProtocol{

    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var forgetPassword: UILabel!
    @IBOutlet weak var fbButn: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureRecognizerLabel();
		
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
//            let loginView : FBSDKLoginButton = FBSDKLoginButton()
//            self.view.addSubview(loginView)
//            loginView.center = self.view.center
            fbButn.readPermissions = ["public_profile", "email", "user_friends"]
            fbButn.delegate = self
        }

        // Do any additional setup after loading the view.
        setupHamburger()
        
        
    }
    
    func setupHamburger()  {
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
<<<<<<< HEAD

=======
// Face book delegate methods
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            print(strFirstName)
            print(strLastName)
            print(strPictureURL)
//            self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
//            self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
            }
>>>>>>> afce4da993ff74b2167f88c1032152137e6d7615

    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
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
