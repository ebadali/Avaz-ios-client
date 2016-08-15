//
//  ForgetPasswordController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/15/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit
import SwiftLoader
import SwiftyJSON

class ForgetPasswordController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    
    var forgetPasswordDelegate: ForgetPasswordDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        print("--viewWillDisappear Called In \(NSStringFromClass(self.classForCoder)) \n")
    }
    @IBAction func Save(sender: UIButton) {
        guard let email = self.email.text, pass = self.password.text , cpass = self.confirmpassword.text where pass == cpass
            else
        {
            return
        }
        
        print(" \(email) ,  \(pass) , \(cpass)")
        
        
        SwiftLoader.show(animated: true)
        
        ApiManager.sharedInstance.ForgetPassApi(email, password: pass, confirmpassword: cpass,
                                              onCompletion:
            {(json : JSON) in
                SwiftLoader.hide()
                
                
                if (json != nil )
                {
                    //Todo: should add Login Here too.
                    print("Responce2 \(json) \n")
                    
                    self.forgetPasswordDelegate.DoneSettingPassword(json["username"].stringValue, password: pass)
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        )
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func Cancle(sender: UIButton) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
