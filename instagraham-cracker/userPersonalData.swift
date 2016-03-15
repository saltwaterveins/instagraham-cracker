//
//  userPersonalData.swift
//  instagraham-cracker
//
//  Created by Stef Epp on 3/13/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit
import Parse

class userPersonalData: NSObject {
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let stuff = PFObject(className: "UserMedia")
        
        // Add relevant fields to the object
        stuff["media"] = getImage(image) // PFFile column type
        stuff["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        stuff["caption"] = caption
        stuff["likesCount"] = 0
        stuff["commentsCount"] = 0
        stuff.saveInBackgroundWithBlock(completion)
    }
    
    
    class func getImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let photo = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: photo)
            }
        }
        return nil
    }
}
