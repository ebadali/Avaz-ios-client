//
//  UploadPostController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/17/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import CoreLocation

class UploadPostController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CLLocationManagerDelegate, HamburgerProtocol{
    @IBOutlet weak var menuItem: UIBarButtonItem!

    lazy var uploadImageView: UIImageView = {
        let iv = self.AddImageToScrollView(UIImage(named: "upload")!)
        iv.userInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.TakeFromCameraAction(_:))))
        return iv
    }()
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")

        // Do any additional setup after loading the view.
        
        // Adding ImageView Callbacks
        
        self.scrollView.addSubview(uploadImageView)
//        addGestureRecognizerLabel()
        setupHamburger()
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        
//        addMoreImages()
    }
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
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
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType]
        if mediaType!.isEqualToString("public.movie"){
            // It is the movie
            
            let videoUrl = info[UIImagePickerControllerMediaURL] as! NSURL!
            let pathString = videoUrl.relativePath
            print("this is url \(pathString)")
            
        }
        else if mediaType!.isEqualToString("public.image"){
            // It is a Image
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.AddImageToScrollView(pickedImage)
            }
        }
        
        //        if editingInfo.UIImagePickerControllerMediaType
        //        if let pickedMovie =
        //        let videoUrl = editingInfo[UIImagePickerControllerMediaURL] as! NSURL!
        //        let pathString = videoUrl.relativePath    }
        //        print("this is url \(pathString)")

    }
    
    func addMoreImages()  {
        for _ in 1...5 {
            let tempImage = UIImage(named: "upload")
            AddImageToScrollView(tempImage!)
        }
    }
    
    func AddImageToScrollView(image: UIImage) -> UIImageView{
        let count = self.scrollView.subviews.count;
//        endIndexx >= 0 ? self.scrollView.subviews[endIndexx].frame.width : 0
        print("count is : \(count) ")
        let iv = UIImageView(frame: CGRect(x: (self.scrollView.frame.width/2)*(CGFloat(count)),y: 0,width: self.scrollView.frame.width/2 , height: self.scrollView.frame.height))
        iv.image = 	image
        iv.contentMode = .ScaleAspectFit
        iv.userInteractionEnabled = true
        
//        iv.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.TakeFromCameraAction(_:))))
        self.scrollView.addSubview(iv)//(iv, atIndex: endIndexx+1)
        self.scrollView.contentSize = CGSizeMake(iv.frame.width * (CGFloat(count+1)), self.scrollView.frame.height)

        return iv
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        
        let location = locations.last! as CLLocation
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            { (placemark, error) ->
                Void in
                
                self.locationManager.stopUpdatingLocation()
                if error != nil {
                    return
                    
                }
                if placemark?.count > 0 {
                    let somePlaceMarker = placemark![0] 
                    self.DisplayLocation(somePlaceMarker)
                
                }
            })
        
    }
    
    func DisplayLocation(placemarker: CLPlacemark)  {
        
        print(placemarker.locality )
        print(placemarker.postalCode )
        print(placemarker.administrativeArea )
        print(placemarker.region )
        print(placemarker.country )
        
        let center = CLLocationCoordinate2D(latitude: placemarker.location!.coordinate.latitude, longitude: placemarker.location!.coordinate.longitude)

        print("lat: \(center.latitude) , lng: \(center.longitude) \n")
        
        
        
    }

}
