//
//  MemeCollectionViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 4/7/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate
{
    
 //Add button to disniss table view and show meme editor
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
   
    
    //Array of Memes
    var memesForCollectionView:[MemeClass]!
    
   

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
         // self.collectionView.reloadData()
    }
    
    //get memes stored in app delegate / assign app delegate memes array to collectionViews array
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        //get memes stored in app delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memesForCollectionView = appDelegate.memesArray
        
        self.collectionView.reloadData()
        
        
    }
    
     //Once App is laucnhed if memes do not exit display meme editor rightaway
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        
        if (self.memesForCollectionView.count == 0)
        {
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            var editmeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
            
            self.presentViewController(editmeme, animated: true, completion: nil)
            
        }
        
    }

    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UICollection View data Source
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
       return self.memesForCollectionView.count
    }

    
    //set and access custom cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        var cell:MemeCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCVcell", forIndexPath: indexPath) as MemeCollectionViewCell
        
        var myMemes = self.memesForCollectionView[indexPath.row]
        
        
        // Set the memed image
        
        cell.collectionVCImageOutlet.image = myMemes.memedImage
        
        
        return cell
    }
    
    
     //Transition to Detailed View Controller
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as MemeDetailViewController
        
        detailVC.meme = self.memesForCollectionView[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }

}
