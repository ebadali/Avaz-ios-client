//
//  UploadPostController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/17/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import CoreLocation
import AVKit
import AVFoundation
import SwiftyJSON

import EZLoadingActivity

class UploadPostController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CLLocationManagerDelegate, HamburgerProtocol{
    
    
    var controllerType = ControllerType.POST
    
    @IBOutlet weak var menuItem: UIBarButtonItem!
    
    
    @IBOutlet weak var mediaSource: MediaSource!
    
    
    @IBAction func createThePost(sender: AnyObject) {
        
        print("creating Posts.")
        
        
        guard let title = self.titleText.text,
            detailText = self.detailText.text
            else
        {
            // Cant Create the post
            return
        }
        
        
        print("lat: \(self.center?.latitude) , lng: \(self.center?.longitude) \n")
        
        // Lets Create a post Object.
        if self.center?.longitude != nil && self.center?.latitude != nil {
            self.mediaObject.content = detailText
            let post = Post(postid:  "unknownid", media: self.mediaObject, title : title, up: 0, down: 0, loc : "", latitude : self.center!.latitude ,longitude : (self.center?.longitude)!)
            
            EZLoadingActivity.show("Posting...", disableUI: true)
            
            ApiManager.sharedInstance.insertAPost(post, onCompletion:
                {(json : JSON) in
                    
                    EZLoadingActivity.hide(success: true, animated: true)
        
                    if (json != nil )
                    {
                        // Got A post.
                        //Todo: Redirect To SomeWhere
                        print("After Posting \n\(json)")
                        
                        DialogHandler.sharedInstance.ShowInfo("Posting Success")
                        
                    }
                    else
                    {

                        DialogHandler.sharedInstance.ShowInfo("Posting Failed")
                    }
                    
            })
            
        }
    }
    
    var mediaArray:[String] = []
    var mediaObject = Media()
    var center: CLLocationCoordinate2D?
    //-------
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var detailText: UITextView!
    
    
    lazy var prevCall: (MediaSourceObject)->() =
        { value in
            
            var refreshAlert = UIAlertController(title: "Action", message: "Select Action", preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Preview", style: .Default, handler: { (action: UIAlertAction!) in
                print("prevCallback Called \(value.cscore)")
                if case .Video() = value.mediaType {
                    self.DisplayVideo(value);
                }else if  case .Image() = value.mediaType {
                    self.DisplayImage(value);
                }
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Remove", style: .Default, handler: { (action: UIAlertAction!) in
                self.mediaSource.Remove(value.url)
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
                print("Handle Cancel Logic here")
            }))
            
            self.presentViewController(refreshAlert, animated: true, completion: nil)
            
            
    }
    
    
    lazy var uploadCall: (MediaSourceObject)->() =
        { value in
            print("uploadCall Called \(value.cscore)")
            self.TakeFromCameraAction()
    }
    
    //    var mediaView : UIView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("--View Did Load Called In \(NSStringFromClass(self.classForCoder)) \n")
        
        
        
        self.AddMediaToScrollView("upload", type: MediaType.Image(), preferedFunc: uploadCall, storeable: false)
        
        
        
        
        setupHamburger()
        
        
        
        //        addMoreImages()
    }
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //        if (CLLocationManager.locationServicesEnabled())
        //        {
        //        }
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        //        self.locationManager.requestAlwaysAuthorization()
        
        
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
        
        UserData.sharedInstance.SetControllerType(self.controllerType)
        
    }
    
    
    func TakeFromCameraAction() {
        
        // Display Pop-Over
        let alertController = UIAlertController(title: "Upload Media", message: "Select Image From", preferredStyle: UIAlertControllerStyle.Alert)
        
        let gallery = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            print("Gallery button tapped")
            
            self.TakeFromGallery()
        })
        
        let camera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: {(alert :UIAlertAction!) in
            print("Camera button tapped")
            self.TakeFromCamera()
            
        })
        
        
        
        
        alertController.addAction(gallery)
        alertController.addAction(camera)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.presentViewController(alertController, animated: true, completion:nil)
        
        //        self.presentViewController(alertController, animated: true, completion:{
        //            alertController.view.superview?.userInteractionEnabled = true
        //            alertController.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
        //        })
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
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .PhotoLibrary;
            imagePicker.mediaTypes = ["public.image", "public.movie"]
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
        //        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType]
        if mediaType!.isEqualToString("public.movie"){
            print("Movie is picked")
            // It is the movie
            
            let videoUrl = info[UIImagePickerControllerMediaURL] as! NSURL!
            let pathString = videoUrl.relativePath
            print("this is url \(pathString)")
            
            self.AddMediaToScrollView(pathString!, type: MediaType.Video(), preferedFunc: self.prevCall)
            
        }
        else if mediaType!.isEqualToString("public.image"){
            print("Image is picked")
            // It is a Image
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                let imageUrl = Utils.SaveImageToDirectory(pickedImage)
                self.AddMediaToScrollView(imageUrl, type: MediaType.Image(), preferedFunc: self.prevCall)
                //                self.AddImageToScrollView(pickedImage)
            }
        }
        
        
    }
    
    
    
    func addMoreImages()  {
        for _ in 1...5 {
            //            let tempImage = UIImage(named: "upload")
            //            AddImageToScrollView(tempImage!)
            let imagePath = "background"
            let urlPath = NSBundle.mainBundle().pathForResource(imagePath, ofType: "gif")
            
            
            let nsurl = NSURL(fileURLWithPath: urlPath!)
            //            let img = NSData(contentsOfURL: nsurl)
            
            
            AddMediaToScrollView(urlPath!, type: MediaType.Image(), preferedFunc: self.prevCall)
        }
        
        
    }
    
    func AddMediaToScrollView(path: String, type: MediaType, preferedFunc : (MediaSourceObject)->(), storeable: Bool = true )  {
        
        
        
        self.mediaSource.AddMedia(path, mediaType: MediaType.Image(), accessType: AccessType.Local(),
                                  prevCallback:  preferedFunc
        )
        
        if (storeable ) {
            self.mediaObject.addMediaContent(path, type: type)
        }
    }
    
    
    
    
    //FIXME: Unused method
    func TabbedOnTile(sender: AnyObject)  {
        // Display Dialog
        let uiAlert = UIAlertController(title: "Title", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(uiAlert, animated: true, completion: nil)
        
        uiAlert.addAction(UIAlertAction(title: "Open", style: .Default, handler: { action in
            print("click opened: \n")
        }))
        
        uiAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { action in
            print("click closed: \n")
        }))
        
    }
    
    func OutFromLargeView(sender: UITapGestureRecognizer)  {
        sender.view?.removeFromSuperview()
    }
    
    func DisplayImage(image: MediaSourceObject)  {
        let newImageView = UIImageView(image: UIImage(contentsOfFile: image.url))
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.OutFromLargeView(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func DisplayVideo(image: MediaSourceObject)  {
        
        let playerViewController = AVPlayerViewController()
        let playerView = AVPlayer(URL: NSURL(fileURLWithPath: image.url))
        playerViewController.player = playerView
        
        self.presentViewController(playerViewController, animated: true){
            playerViewController.player?.play()
        }
    }
    
    
    
    
    func VideoClickListner(sender: AnyObject)  {
        print("Video Listner")
        //        let playerViewController = AVPlayerViewController()
        //        let playerView = AVPlayer("")
        //        playerViewController.player = playerView
        //
        //        self.presentViewController(playerViewController, animated: true){
        //            playerViewController.player?.play()
        //        }
        
    }
    func ImageClickListner(sender: AnyObject)  {
        print("Image Listner")
    }
    
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error = \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("locations = \(locations)")
        
        let location = locations.last! as CLLocation
        self.center = location.coordinate
        self.locationManager.stopUpdatingLocation()
        //        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
        //            { (placemark, error) ->
        //                Void in
        //
        //                self.locationManager.stopUpdatingLocation()
        //                if error != nil {
        //                    return
        //
        //                }
        //                if placemark?.count > 0 {
        //                    let somePlaceMarker = placemark![0]
        //                    self.DisplayLocation(somePlaceMarker)
        //
        //                }
        //            })
    }
    
    
    func DisplayLocation(placemarker: CLPlacemark)  {
        
        print(placemarker.locality )
        print(placemarker.postalCode )
        print(placemarker.administrativeArea )
        print(placemarker.region )
        print(placemarker.country )
        
        self.center = CLLocationCoordinate2D(latitude: placemarker.location!.coordinate.latitude, longitude: placemarker.location!.coordinate.longitude)
        
        print("lat: \(center!.latitude) , lng: \(center!.longitude) \n")
        
        
        
    }
    
}
