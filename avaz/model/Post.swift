//
//  Post.swift
//  avaz
//
//  Created by Nerdiacs Mac on 5/30/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

class Post {
        var tex1 = ""
        var tex2 = ""
        var up = 0 , down = 0
        
        init(text1 : String, text2 : String, up: Int, down: Int )
        {
            self.tex1 = text1
            self.tex2 = text2
            self.up = up
            self.down = down
        }
        
}