//
//  HomeTableViewCell.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

@objc protocol HomeTableViewCellDelegate {
    func didSelectPhoto(homeTableViewCell: HomeTableViewCell)
    func didSelectUser(homeTableViewCell: HomeTableViewCell)
}

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userImageView: PFImageView!
    @IBOutlet weak var userCaptionLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var delegate: HomeTableViewCellDelegate?
    var createdDate: String?
    
    var post: PFObject! {
        didSet {
            self.postImageView.file = post["media"] as? PFFile
            self.postImageView.loadInBackground()
            let author = post["author"] as! PFUser
            self.userImageView.file = author["picture"] as? PFFile
            self.userImageView.loadInBackground()
            self.userLabel.text = author.username
            self.captionLabel.text = post["caption"] as? String
            self.userCaptionLabel.text = author.username
            let date = post.createdAt!
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            self.createdDate = formatter.string(from: date)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func photoTap(_ sender: Any) {
        delegate!.didSelectPhoto(homeTableViewCell: self)
    }
    
    @IBAction func userTap(_ sender: Any) {
        delegate!.didSelectUser(homeTableViewCell: self)
    }
    
}
