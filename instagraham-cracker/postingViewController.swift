//
//  postingViewController.swift
//  instagraham-cracker
//
//  Created by Stef Epp on 3/15/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit
import Parse

class postingViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var caption: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        caption.delegate = self
        var photo = image
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("addImageTapped:"))
        photo.userInteractionEnabled = true
        photo.addGestureRecognizer(tapGestureRecognizer)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImageTapped(img: AnyObject) {
        let adder = UIImagePickerController()
        adder.delegate = self
        adder.allowsEditing = true
        adder.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(adder, animated: true, completion: nil)
        
    }
    
    @IBAction func composeTapped(sender: AnyObject) {
        
        userPersonalData.postUserImage(image.image, withCaption: caption.text) { (success: Bool, error: NSError?) -> Void in
            if success {
                self.image.image = nil
                self.caption.text = ""
            }

        }
    }
    
    func PhotoResize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizing = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizing.contentMode = UIViewContentMode.ScaleAspectFill
        resizing.image = image
        
        UIGraphicsBeginImageContext(resizing.frame.size)
        resizing.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }

    func PickImage(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let firstImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let newImage = info[UIImagePickerControllerEditedImage] as! UIImage
            
            image.image = newImage
            dismissViewControllerAnimated(true, completion: { () -> Void in
            })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
