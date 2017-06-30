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

@objc protocol ProfileCollectionViewCellDelegate {
    func didSelectPhoto(profileCollectionViewCell: ProfileCollectionViewCell)
}

class ProfileCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var profilePostImageView: PFImageView!
    
    var delegate: ProfileCollectionViewCellDelegate?
    var caption: String?
    var createdDate: String?
    
    var post: PFObject! {
        didSet {
            self.profilePostImageView.file = post["media"] as? PFFile
            self.profilePostImageView.loadInBackground()
            self.caption = post["caption"] as? String
            let date = post.createdAt!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            self.createdDate = formatter.string(from: date)
            
        }
    }
    
    @IBAction func photoTap(_ sender: Any) {
        delegate!.didSelectPhoto(profileCollectionViewCell: self)
    }
}
