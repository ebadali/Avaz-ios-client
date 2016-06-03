//
//  Votes.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class Votes: UIView {
    @IBOutlet var view: Votes!
        
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSBundle.mainBundle().loadNibNamed("VotesView", owner: self, options: nil)
        
//        UINib(nibName: "VotesView", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(view)
        view.frame = self.bounds
    }
    
    
}
