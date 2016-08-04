//
//  LoginViewController.swift
//  avaz
//
//  Created by ebad ali on 6/20/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate{
    
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var forgetPassword: UILabel!
    @IBOutlet weak var fbButn: FBSDKLoginButton!
    
    
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    
    @IBAction func LogIn(sender: AnyObject) {
        print("logging in")
        
        print (" \(self.email.text)")
        print (" \(self.password.text)")
        
        guard let email = self.email.text , password = self.password.text else {
            return
        }
        
         self.dismissViewControllerAnimated(true, completion: nil)
        
//        ApiManager.sharedInstance.LogInApi(email, password: password,
//                onCompletion:
//            {(json : JSON) in
//                
//                    if (json != nil )
//                    {
//                        UserData.sharedInstance.SetSessionID(String(json["sessionid"]))
//                        UserData.sharedInstance.SetCurrentUser(json["user"])
//                        
//                        //Todo: Redirect To SomeWhere
//                        print("Login \n\(json)")
//                        
//                        
//                        ApiManager.sharedInstance.getAllPost { (json : JSON) in
//                            
//                            if (json != nil )
//                            {
//                                
//                                
//                                //Todo: Redirect To SomeWhere
//                                print("getAllPost \n\(json)")
//                                
//                            }
//                            
//                        }
//                    }
//                    
//            }
//        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imagePAth = "background"
        AddGif(imagePAth);
        

        print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")
        
        
//        activityIndicator.hidesWhenStopped = true;
//        activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
//        activityIndicator.center = self.view.center;
//
//        self.view.addSubview(activityIndicator)
//
        
        
		
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            fbButn.readPermissions = ["public_profile", "email", "user_friends"]
            fbButn.delegate = self
        }

        // Do any additional setup after loading the view.
        addGestureRecognizerLabel();
        
//        LoadSomeTask()
        
        
        
    }
    

    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
    }
    
    func AddGif(path: String)  {
        // Creating Backgorund View
        let iv = UIWebView(frame: self.view.frame)

        let urlPath = NSBundle.mainBundle().pathForResource(path, ofType: "gif")
        

        let nsurl = NSURL(fileURLWithPath: urlPath!)
        let img = NSData(contentsOfURL: nsurl)
        iv.loadData(img!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
        iv.userInteractionEnabled = false;
        iv.scalesPageToFit = true;
//        iv.contentMode = .ScaleToFill;
        self.view.insertSubview(iv, atIndex: 0)
        
        // Creating Filter
        let filter = UIView()
        filter.frame = self.view.frame
        filter.backgroundColor = UIColor.blackColor()
        filter.alpha = 0.2
        self.view.insertSubview(filter, atIndex: 1)
        
        iv.center = self.view.center
        filter.center = self.view.center
        
//        iv.setTranslatesAutoresizingMaskIntoConstraints(false)
        
//        iv.addConstraint(NSLayoutConstraint(item: iv, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
//        iv.addConstraint(NSLayoutConstraint(item: iv, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))

        
    }

    func LoadSomeTask()  {
        
        activityIndicator.startAnimating()        
        let triggerTime = (Int64(NSEC_PER_SEC) * 5)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            self.activityIndicator.stopAnimating()
        })
        

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
// Face book delegate methods
    
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"]).startWithCompletionHandler { (connection, result, error) -> Void in
                if result != nil
                {
                    guard let strFirstName = (result.objectForKey("first_name") as? String), strLastName = (result.objectForKey("last_name") as? String) , strPictureURL = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)
                        else{
                            return
                    }
                    print(strFirstName)
                    print(strLastName)
                    print(strPictureURL)
                    
                }
//            self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
//            self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
            }

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
        gestureRecognizer.addTarget(self, action: #selector(LoginViewController.ShowForgetPassword))
        
        //Add this gesture to your view, and "turn on" user interaction
        forgetPassword.addGestureRecognizer(gestureRecognizer)
        forgetPassword.userInteractionEnabled = true
    }
    
    
    
    func ShowForgetPassword(){
        //Your code here
        
        
        print("Hi, Forget Password was clicked.")
        
        
        // Display Pop-Over
        let alertController = UIAlertController(title: "Forgot Password?", message: "Enter Your Email to Setup a New Password", preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addTextFieldWithConfigurationHandler() { textField in
            textField.frame.size.height = 33
            textField.backgroundColor = nil
            textField.layer.borderColor = nil
            textField.layer.borderWidth = 0
        }
        
        let sendEmail = UIAlertAction(title: "Send", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            print("Gallery button tapped")
            
            guard let forgotPassEmail = alertController.textFields![0].text else
            {
                return
            }
            
            print(forgotPassEmail)
            
        })
        
        alertController.addAction(sendEmail)
        
        self.presentViewController(alertController, animated: true, completion:{
            alertController.view.superview?.userInteractionEnabled = true
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
        
//        self.performSegueWithIdentifier("Refister_view_segue", sender: self)
    }
    
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

extension ViewController{
    override func viewDidAppear(animated: Bool) {
        if animated {
            
        }
    }
}
