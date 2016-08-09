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
    
    var textContent: String?,
    imageUrl : String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    func setData(text: String?, posterImageUrl : String?)  {
        
        
//        guard let tempText = text ,
//                tempUrl = posterImageUrl
//        where
//        self.textContent != nil && self.imageUrl != nil else
//        {
//            // Already Exists.
//            return
//        }
        
        
//        print("in the CommentView ")        
        self.textContent = text
        self.imageUrl = posterImageUrl

        
        
        self.commenterText.text = self.textContent
        self.commenterImage.loadImageRemotely(self.imageUrl!)
        // Lets Load An Image.
        
        
    }
}




