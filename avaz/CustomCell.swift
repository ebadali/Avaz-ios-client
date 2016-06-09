//
//  UICustomCell.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//


import UIKit

class CustomCell: UITableViewCell {
    
    

    @IBOutlet weak var priorityImageView: UIImageView!
    
    @IBOutlet weak var headingTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

