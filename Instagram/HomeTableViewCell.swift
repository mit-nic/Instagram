//
//  HomeTableViewCell.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var commentLabel: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userCaptionLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
