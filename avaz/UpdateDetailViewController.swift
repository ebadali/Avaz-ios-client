//
//  UpdateDetailViewController.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/2/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class UpdateDetailViewController: UIViewController {

    @IBOutlet weak var labelView: UILabel!
    
    var data : Post!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        labelView.text = data.tex1;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
