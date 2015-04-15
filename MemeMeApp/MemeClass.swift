//
//  MemeClass.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 3/29/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import Foundation
import UIKit

class MemeClass
{
    // properties and methods
    
    var topTextField:String
    var bottomTextField:String
    var originalImage: UIImage
    
    //final memedImage Needed for Detail View Controller
    var memedImage: UIImage
    
    
    //init method
    
    init(textTop:String, textBottom: String, image:UIImage, mImage:UIImage)
    {
        self.topTextField = textTop
        self.bottomTextField = textBottom
        self.originalImage = image
        self.memedImage = mImage
    }
    
}

