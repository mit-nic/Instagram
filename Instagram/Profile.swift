//
//  Profile.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/29/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse

class Profile: NSObject {

    class func createUserProfile(image: UIImage?, withDescription description: String?, withCompletion completion: PFBooleanResultBlock?) {
        let profile = PFObject(className: "Profile")
        
        profile["author"] = PFUser.current()
        profile["description"] = description ?? ""
        profile["image"] = getPFFileFromImage(image: image)
        
        profile.saveInBackground(block: completion)
    }
    
    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        if let image = image {
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
}
