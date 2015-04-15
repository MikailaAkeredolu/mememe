//
//  MemeTableViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 4/1/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
    
    //Add button to disniss table view and show meme editor
    
    @IBAction func addButton(sender: UIBarButtonItem)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //Array of Memes
    
    var memesForTable:[MemeClass]!
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    //Once App is laucnhed if memes do not exit display meme editor rightaway
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        
        if (self.memesForTable.count == 0)
        {
           var storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            var editmeme = storyboard.instantiateViewControllerWithIdentifier("MemeEditorViewController") as MemeEditorViewController
            
            self.presentViewController(editmeme, animated: true, completion: nil)
            
        }

    }
    
     //get memes stored in app delegate / assign app delegate memes array to tableviews array
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memesForTable = appDelegate.memesArray
        
        self.tableView.reloadData()
        
    }
    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    // UITableView Data Sources
    
    func tableView(tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        
        return self.memesForTable.count
 
    }
    
   
    func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell
    {
      
        //set up custom cell

        var cell:MemeTableViewCell = tableView.dequeueReusableCellWithIdentifier("myTableViewCell") as MemeTableViewCell
        
        var myMemes = self.memesForTable[indexPath.row]
     
        // Set image
        
        cell.imageForTable.image = myMemes.memedImage
        
        return cell
        
               
    }
    
    //Transition to Detailed View Controller

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let detailVC = self.storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as MemeDetailViewController
        
        detailVC.meme = self.memesForTable[indexPath.row]
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
    