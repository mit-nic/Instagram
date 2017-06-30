//
//  ProfileCollectionViewCell.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profilePostImageView: PFImageView!
    
    var post: PFObject! {
        didSet {
            self.profilePostImageView.file = post["media"] as? PFFile
            self.profilePostImageView.loadInBackground()
        }
    }
    
}
