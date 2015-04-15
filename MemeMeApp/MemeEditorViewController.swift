//
//  MemeEditorViewController.swift
//  MemeMeApp
//
//  Created by Mikaila Akeredolu on 3/23/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit
import MobileCoreServices

class MemeEditorViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate
{
    
    var memes:[MemeClass]! 
    
    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    
    @IBOutlet weak var topTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var bottomTextFieldOutlet: UITextField!
    
    
    @IBOutlet weak var cancelButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var cameraButtonOutlet: UIBarButtonItem!
    
    
    @IBOutlet weak var shareButtonOutlet: UIBarButtonItem!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
   
    
    //hide status bar
    override func prefersStatusBarHidden() ->Bool{
    
    return true
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
       // self.topToolBar.hidden = false
        
        
    self.prefersStatusBarHidden()
        
        //set textfields delegate
        
        self.topTextFieldOutlet.delegate = self
        self.bottomTextFieldOutlet.delegate = self
        

        // Set Text properties
        
        self.topTextFieldOutlet.text =  "TOP"
        
        self.bottomTextFieldOutlet.text = "BOTTOM"
    
        
        let memeTextAttributes =
        [
            NSStrokeColorAttributeName : UIColor.blackColor(), //TODO: Fill in appropriate UIColor,
            NSForegroundColorAttributeName : UIColor.whiteColor(), //TODO: Fill in UIColor,
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -3.0 //TODO: Fill in appropriate Float
        ]
        
        
        self.topTextFieldOutlet.defaultTextAttributes = memeTextAttributes
        self.topTextFieldOutlet.textAlignment = NSTextAlignment.Center
    
        
        self.bottomTextFieldOutlet.defaultTextAttributes = memeTextAttributes
        self.bottomTextFieldOutlet.textAlignment = NSTextAlignment.Center
        
        //disable sharing
        self.shareButtonOutlet.enabled = false
        
        //access memes stored in app delegate
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        
        memes = appDelegate.memesArray
    }
    
    //share meme via activity controller then show tab bar controller
    
         @IBAction func shareButton(sender: UIBarButtonItem)
         {
        
        self.shareButtonOutlet.enabled = true
    
        //generate a memed image
        
        self.generateMemedImage()
        
        let memeToShare = [self.generateMemedImage()] //make this an array
        
        let activityVC = UIActivityViewController(activityItems: memeToShare, applicationActivities: nil)
        
        
        //implement completion handler

        activityVC.completionWithItemsHandler = {activity,completed,items,error in
        
            //statements
            if completed
            {
                self.save()
                
                //self.dismissViewControllerAnimated(true, completion: nil)
            }
        
        }
            self.presentViewController(activityVC, animated: true, completion:nil)
            
               showTabBarController()
    }
         
    
    //create Save function that initializes a memeModel
    
    func save()
    {
        //create the meme
        
        var memeImage = MemeClass(textTop: self.topTextFieldOutlet.text!, textBottom: self.bottomTextFieldOutlet.text!, image: self.imageViewOutlet.image!, mImage: self.generateMemedImage())
       
        //add to memesImage to array in app delegate
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        
        appDelegate.memesArray.append(memeImage)
        
        
        //show tab bar controller

        showTabBarController()

    }
    
    
    func generateMemedImage() -> UIImage
    {
        
        //hide toolbars
        
        self.bottomToolBar.hidden = true
        self.topToolBar.hidden = true
        
        //render view to an image
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        
        self.view.drawViewHierarchyInRect(self.view.frame,  afterScreenUpdates: true)
        
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
         //show toolbars
        self.bottomToolBar.hidden = false
        self.bottomToolBar.hidden = false
        
        return memedImage
        
    }

    
    //transition to tab bar
    
    func showTabBarController()
    {
        
        var tabController:UITabBarController
        tabController = self.storyboard?.instantiateViewControllerWithIdentifier("tabBarController")
        as UITabBarController
        
        self.presentViewController(tabController, animated: true, completion: nil)
        
    }
    
    
    //keyboard resign first responder
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true;
    }
    
    //Implement text field delegate protocol and capitalize strings
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
    {
        
        let newText = (textField.text as NSString).stringByReplacingCharactersInRange(range, withString: string)
        textField.text = newText.uppercaseString
        
        return false
        
    }
    

        
    @IBAction func cameraButton(sender: UIBarButtonItem)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        {
        
        //launch uiimagePicker Controller
        
        let camerapickerController = UIImagePickerController()
        camerapickerController.delegate = self
        
        camerapickerController.sourceType = UIImagePickerControllerSourceType.Camera
        
        //set up the media types as an array that holds [anyobject]
        let mediaTypes:[AnyObject] = [kUTTypeImage] //represents imagedata
        camerapickerController.mediaTypes = mediaTypes
        camerapickerController.allowsEditing = true
            
        
        self.presentViewController(camerapickerController, animated: true, completion: nil)
            
               self.shareButtonOutlet.enabled = true
        
        }else
        {
            
            //alert if camera is not available
            
            var alertController = UIAlertController(title: "Alert", message: "Your device does not have a camera", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)

        }
        

    }
    

    @IBAction func albumButton(sender: UIBarButtonItem)
    {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary)
        {
        
        //launch uiimagePicker Controller
        
        let albumpickerController = UIImagePickerController()
        albumpickerController.delegate = self
        
        albumpickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        //set up the media types as an array that holds [anyobject]
        let mediaTypes:[AnyObject] = [kUTTypeImage] //represents imagedata
        albumpickerController.mediaTypes = mediaTypes
        albumpickerController.allowsEditing = true
            
        
        self.presentViewController(albumpickerController, animated: true, completion: nil)
            
               self.shareButtonOutlet.enabled = true
            
       
        }else
        {
            
            
            //alert if camera is not available
            var alertController = UIAlertController(title: "Alert", message: "Your device does not support the photo library", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
                      
        }

    }
    
    
    
    //Image Picker Controller Delegate Method
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        
        //when we select an image..it will be stored here in constant -- 
        
        if  let image = info[UIImagePickerControllerEditedImage] as? UIImage
        { 
            //specify as UIImage
            
            self.imageViewOutlet.image = image
            
        }else
        {
            
            let image = info[UIImagePickerControllerOriginalImage] as? UIImage
             self.imageViewOutlet.image = image
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
 
       
    }
    
    //Image Picker Controller Delegate Method
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        
          self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    
    override func viewWillAppear(animated: Bool)
    {
        
        
        //sign up to be notified when keyboard appears
        super.viewWillAppear(animated)
        
        self.topToolBar.hidden = false
        
        
       // disable camera button below
        
            self.cameraButtonOutlet.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardwilhideNotifications()
    }

    //create and subcribe to notification function to be called in viewWillAppear
    
    func subscribeToKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    
    //create and Subscribe to the keyboard notification: UIKeyboardWillHideNotification
   
    func subscribeToKeyboardwilhideNotifications()
    {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    

    // call unsuscribe methods
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardwillhideNotifications()
    }
    
    
    //unsuscribe from notification function to be called in viewWillDisAppear
    
    func unsubscribeFromKeyboardNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    

    
    //unsuscribe from keyborad will hide notificaton in viewWillDissapear
    
    func unsubscribeFromKeyboardwillhideNotifications()
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
   // When the keyboardWillShow notification is received, shift the view's frame up
    
    func keyboardWillShow(notification: NSNotification)
    {
    
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    //get the keyboard height
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat
    {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        
        if bottomTextFieldOutlet.editing{
            return keyboardSize.CGRectValue().height
        }else
        {
            return 0
        }
        
       // return keyboardSize.CGRectValue().height
        
    }
    
    
    
   // Write the method “keyboardWillHide” to move the view frame down a distance equal to the keyboardHeight.
    
    
    func keyboardWillHide(notification: NSNotification)
    {
        
         self.view.frame.origin.y += getKeyboardHeight(notification)
        
    }
  
  
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func cancelButton(sender: UIBarButtonItem)
    {
        
        showTabBarController()

    }
    
}
