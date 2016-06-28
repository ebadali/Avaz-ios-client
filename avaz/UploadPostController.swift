//
//  UploadPostController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/17/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class UploadPostController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Adding ImageView Callbacks
        addGestureRecognizerLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func TakeFromCamera()  {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.mediaTypes =  ["public.image", "public.movie"]

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
    
    func TakeFromVideo()  {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            
//            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.mediaTypes =  ["public.image", "public.movie"]
            //            imagePicker.allowsEditing = false
            self.presentViewController(imagePicker, animated: true, completion: {
                print("Done With Image")
                
            })
        }
        
    }
    func alertControllerBackgroundTapped()
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {

        self.dismissViewControllerAnimated(true, completion: nil);
        imageView.image = image
        

        
        
        let videoUrl = editingInfo[UIImagePickerControllerMediaURL] as! NSURL!
        let pathString = videoUrl.relativePath
        print("this is url \(pathString)")

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
        gestureRecognizer.addTarget(self, action: #selector(self.TakeFromCameraAction))
        
        //Add this gesture to your view, and "turn on" user interaction
        imageView.addGestureRecognizer(gestureRecognizer)
        imageView.userInteractionEnabled = true
        
        
        
        let videoViewGestureRecognizer = UITapGestureRecognizer()
        
        //Gesture configuration
        videoViewGestureRecognizer.numberOfTapsRequired = 1
        videoViewGestureRecognizer.numberOfTouchesRequired = 1
        /*Add the target (You can use UITapGestureRecognizer's init() for this)
         This method receives two arguments, a target(in this case is my ViewController)
         and the callback, or function that you want to invoke when the user tap it view)*/
        videoViewGestureRecognizer.addTarget(self, action: #selector(self.TakeFromVideo))

        videoView.addGestureRecognizer(videoViewGestureRecognizer)
        videoView.userInteractionEnabled = true
        
        
    }
}
