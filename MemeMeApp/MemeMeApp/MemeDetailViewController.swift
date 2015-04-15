//
//  MemeDetailViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 4/7/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    

    @IBOutlet weak var detailMemeOutlet: UIImageView!
    
    var meme:MemeClass!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailMemeOutlet.image = meme.memedImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
