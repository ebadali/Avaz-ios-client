//
//  LoginView.swift
//  avaz
//
//  Created by ebad ali on 7/1/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class LoginView: UIView {

    @IBOutlet var view: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
                
        UINib(nibName: "LoginView",bundle: nil).instantiateWithOwner(self, options: nil)
        
        addSubview(view)
 
        view.frame = self.bounds
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
     }
    

}
