//
//  CommentView.swift
//  avaz
//
//  Created by ebad ali on 6/5/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import UIKit

class CommentView: UITableViewCell {
    
    @IBOutlet weak var commenterImage: UIImageView!
    @IBOutlet weak var commenterText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
