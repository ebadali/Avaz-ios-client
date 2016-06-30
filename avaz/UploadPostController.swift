//
//  UploadPostController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/17/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class UploadPostController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, HamburgerProtocol{
    @IBOutlet weak var menuItem: UIBarButtonItem!

    lazy var uploadImageView: UIImageView = {
        

        
        let iv = self.AddImageToScrollView(UIImage(named: "upload")!)
        iv.userInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.TakeFromCameraAction(_:))))
        return iv
    }()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Adding ImageView Callbacks
        
        self.scrollView.addSubview(uploadImageView)
//        addGestureRecognizerLabel()
        setupHamburger()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupHamburger() {
        if self.revealViewController() != nil {
            menuItem.target = self.revealViewController()
            menuItem.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
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
        
        self.AddImageToScrollView(image)

        
        
//        let videoUrl = editingInfo[UIImagePickerControllerMediaURL] as! NSURL!
//        let pathString = videoUrl.relativePath
//        print("this is url \(pathString)")

    }
    
    
    func AddImageToScrollView(image: UIImage) -> UIImageView{
        
        let endIndexx = self.scrollView.subviews.endIndex
//        endIndexx >= 0 ? self.scrollView.subviews[endIndexx].frame.width : 0
        
        let iv = UIImageView(frame: CGRect(x: (endIndexx == 0 || endIndexx == 1) ? self.scrollView.subviews[endIndexx].frame.width : 0  ,y: 0,width: self.scrollView.frame.width/2 , height: self.scrollView.frame.height))
        iv.image = 	image
        iv.userInteractionEnabled = true
        

        
//        iv.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.TakeFromCameraAction(_:))))
        self.scrollView.addSubview(iv)//(iv, atIndex: endIndexx+1)
//        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * 2, self.scrollView.frame.height)
        return iv
    }

}
