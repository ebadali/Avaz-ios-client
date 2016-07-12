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

class UploadPostController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CLLocationManagerDelegate, HamburgerProtocol{
    @IBOutlet weak var menuItem: UIBarButtonItem!

    lazy var uploadImageView: UIImageView = {
        let iv = self.AddImageToScrollView(UIImage(named: "upload")!)
        iv.userInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target:self, action:#selector(self.TakeFromCameraAction(_:))))
        return iv
    }()

    
    //-------
    @IBOutlet weak var titleText: UITextField!
    
    @IBOutlet weak var detailText: UITextView!
    
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
        
        addMoreImages()
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
        self.dismissViewControllerAnimated(true, completion: nil)
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
            
            self.AddMediaToScrollView(pathString!, type: MediaType.Video())
            
        }
        else if mediaType!.isEqualToString("public.image"){
            print("Image is picked")
            // It is a Image
            if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                
                let imageUrl = SaveImageToDirectory(pickedImage)
                self.AddMediaToScrollView(imageUrl, type: MediaType.Image())
//                self.AddImageToScrollView(pickedImage)
            }
        }
        

    }
    func SaveImageToDirectory(image: UIImage) -> String {
        
            if let data = UIImageJPEGRepresentation(image, 0.2) {
                
                let filename = Utils.getDocumentsDirectory().stringByAppendingPathComponent("copy.jpg")
                data.writeToFile(filename, atomically: true)
                
                return filename
            }
        
            return ""
        
    }
    
    
    func addMoreImages()  {
        for _ in 1...5 {
//            let tempImage = UIImage(named: "upload")
//            AddImageToScrollView(tempImage!)
            let imagePath = "background"
            let urlPath = NSBundle.mainBundle().pathForResource(imagePath, ofType: "gif")
            
            
//            let nsurl = NSURL(fileURLWithPath: urlPath!)
//            let img = NSData(contentsOfURL: nsurl)
            AddMediaToScrollView(urlPath!, type: MediaType.Image())
        }
        
        
    }
    
    func AddMediaToScrollView(path: String, type: MediaType)  {
        let count = self.scrollView.subviews.count-2;
        print("count is : \(count) ")
        
        // Todo: There should be a custom view which have:
        // a. cancle button to drop the media,
        // b. play tab callback to display the Media
        print("x is : \((self.scrollView.frame.width/2)*(CGFloat(count)))")
        
        
        let iv = CustomMediaCell(frame: CGRect(x: (self.scrollView.frame.width/2)*(CGFloat(count)),y: 10,width: self.scrollView.frame.width/2 , height: self.scrollView.frame.height-10), url: path, mediaType: type)

        iv.userInteractionEnabled = true
        iv.tag = count
        // Important callbacks.
        iv.previewCallback = {
            print("preview Called")
            if case .Video() = iv.mediaType {
                self.DisplayVideo(iv);
                
            }else if  case .Image() = iv.mediaType {
                self.DisplayImage(iv);
            }

            
        }
        
        iv.cancleCallback = {
            print("cancled Called")
            self.RemoveThisMediaCell(iv)
            
        }
        
        
//        let urll = "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"
//                let iframe = "<iframe  src=\"\(urll)\" > </iframe> "
//        let iframe = "<iframe  src=\"\(NSURL(fileURLWithPath: path))\" > </iframe> "
        //        iv.loadHTMLString(iframe, baseURL: nil)
 //        let nsurl = NSURL(fileURLWithPath: path)
//        let img = NSData(contentsOfURL: nsurl)
//        iv.loadData(img!, MIMEType: "image/gif", textEncodingName: String(), baseURL: NSURL())
//        iv.image = UIImage(contentsOfFile: path)
//        iv.userInteractionEnabled = true;
        iv.contentMode = .ScaleAspectFit
        self.scrollView.addSubview(iv)//(iv, atIndex: endIndexx+1)
        
        
        self.scrollView.contentSize = CGSizeMake(iv.frame.width * (CGFloat(count+1)), self.scrollView.frame.height)
      
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
    
    func DisplayImage(image: CustomMediaCell)  {
        let newImageView = UIImageView(image: UIImage(contentsOfFile: image.url))
        newImageView.frame = self.view.frame
        newImageView.backgroundColor = .blackColor()
        newImageView.contentMode = .ScaleAspectFit
        newImageView.userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action:#selector(self.OutFromLargeView(_:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
    
    func DisplayVideo(image: CustomMediaCell)  {
        
        let playerViewController = AVPlayerViewController()
        let playerView = AVPlayer(URL: NSURL(fileURLWithPath: image.url))
        playerViewController.player = playerView
        
        self.presentViewController(playerViewController, animated: true){
            playerViewController.player?.play()
        }
    }
    
    func RemoveThisMediaCell(image: CustomMediaCell)  {
//        print("try to this \(image.tag)")
        // Do indexing 
        
        //FIXME: Move back all the cells by recalculating their positions.
        
        var found = false;
        var counter = 0
        for subview in self.scrollView.subviews  {
//            print("Removing this \(subview.tag)")
            
            if found {
                subview.frame.origin.x = (subview.frame.origin.x-image.frame.width)
                counter += 1
            }
            else if subview.tag == image.tag {
                subview.removeFromSuperview()
                found = true
            }
            
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
    
    
    func AddImageToScrollView(image: UIImage) -> UIImageView{
        let count = self.scrollView.subviews.count-2;
//        endIndexx >= 0 ? self.scrollView.subviews[endIndexx].frame.width : 0
        print("count is in add image scrollview: \(count) ")
        let iv = UIImageView(frame: CGRect(x: (self.scrollView.frame.width/2)*(CGFloat(count)),y: 0,width: self.scrollView.frame.width/2 , height: self.scrollView.frame.height-10))
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
