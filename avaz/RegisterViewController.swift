//
//  RegisterViewController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/22/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftyJSON



class RegisterViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    var signUpCompletedDelegate:SignUpDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addGestureRecognizerLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
    }

    @IBAction func SignUp(sender: AnyObject) {
        guard let username = self.userName.text, email = self.email.text , password = self.password.text
             else
        {
            return
        }
  
        //1. Save the Image
        //2. Get the Url
        let imageUrl = (self.imageView.image != nil )  ?  Utils.SaveImageToDirectory(self.imageView.image!)  : ""
        //3. Send the Url to the Api Manager.
        
        print(" \(username) , \(email) ,  \(password) , \(imageUrl)")
        
        
        ApiManager.sharedInstance.RegsiterApi(username, email: email, password: password, pic: imageUrl,
                                           onCompletion:
            {(json : JSON) in
                
                print("Responce1 \(json) \n")
                
                
                if (json != nil )
                {
                    //Todo: should add Login Here too.
                    print("Responce2 \(json) \n")
                    self.signUpCompletedDelegate.DoneSigningUp(username, password: password)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        )
        
        
    }
    @IBAction func AlreadyHaveAnAcount(sender: AnyObject) {
//        self.navigationController!.popViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
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
        gestureRecognizer.addTarget(self, action: #selector(self.TakeFromCameraAction(_:)))
        
        //Add this gesture to your view, and "turn on" user interaction
        imageView.addGestureRecognizer(gestureRecognizer)
        imageView.userInteractionEnabled = true
    }

    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType]
        if mediaType!.isEqualToString("public.movie"){
            // It is the movie
            
            // Do Nothing
            
        }
        else if mediaType!.isEqualToString("public.image"){
            // It is a Image
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                

                self.imageView.clipsToBounds = true
//                                //half of the width
//                self.imageView.layer.cornerRadius = self.imageView.frame.width
                self.imageView.image = pickedImage

                
                
            }
        }
        
        //        if editingInfo.UIImagePickerControllerMediaType
        //        if let pickedMovie =
        //        let videoUrl = editingInfo[UIImagePickerControllerMediaURL] as! NSURL!
        //        let pathString = videoUrl.relativePath    }
        //        print("this is url \(pathString)")
        
    }
    func TakeFromCameraAction(sender: AnyObject) {
        
        // Display Pop-Over
        let alertController = UIAlertController(title: "Select Source", message: "Select Image From", preferredStyle: UIAlertControllerStyle.Alert)
        
        let gallery = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            print("Gallery button tapped")
            
            self.TakeFromGallery()
        })
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            print("Camera button tapped")
            
            if(!alertController.isBeingDismissed())
            {
                self.TakeFromCamera()
            }
            
        })
        
        
        alertController.addAction(gallery)
        alertController.addAction(camera)
        
        self.presentViewController(alertController, animated: true, completion:{
            alertController.view.superview?.userInteractionEnabled = true
            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        })
    }
    // Cancles the image picekr
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func TakeFromCamera()  {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.mediaTypes =  ["public.image"]
            
            //            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func TakeFromGallery()  {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary;
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
   
}
