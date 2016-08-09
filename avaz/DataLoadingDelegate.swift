//
//  DataLoadingDelegate.swift
//  avaz
//
//  Created by Nerdiacs Mac on 8/8/16.
//  Copyright © 2016 Nerdiacs. All rights reserved.
//

import Foundation

import SwiftyJSON

protocol SignInDelegate
{
    func DoneSigningIn(posts : JSON)
}


protocol SignUpDelegate
{
    func DoneSigningUp(username : String, password: String)
}


protocol PreviewDelegate
{
    func PreviewVideo(mediaObject : CustomMediaCell)
    func PreviewImage(mediaObject : CustomMediaCell)
}