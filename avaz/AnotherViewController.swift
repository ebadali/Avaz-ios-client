//
//  AnotherViewController.swift
//  avaz
//
//  Created by ebad ali on 6/8/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var firstTextView: UITextView!
    
    @IBOutlet weak var secondTextView: UITextView!
    
    override func viewDidLoad() { 
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstTextView.text = firstTextView.text[firstTextView.text.startIndex.advancedBy(0)...firstTextView.text.startIndex.advancedBy(20)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
