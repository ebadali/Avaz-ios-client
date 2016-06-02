//
//  VotesView.swift
//  avaz
//
//  Created by Nerdiacs Mac on 6/2/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class VotesView: UIView {

    @IBOutlet var rootView: UIView!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        UINib(nibName: "VotesView", bundle: nil).instantiateWithOwner(self, options: nil)
        addSubview(rootView)
        rootView.frame = self.bounds
    }

}
