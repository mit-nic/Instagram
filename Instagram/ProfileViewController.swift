//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var user: PFUser = PFUser.current()!
    var posts: [PFObject]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh()
        
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        userLabel.text = user.username
        descriptionLabel.text = user["bio"] as? String
        
        profileImageView.file = user["picture"] as? PFFile
        profileImageView.loadInBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func refresh() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: user)
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.posts = objects
//                self.homeTableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let vc = segue.destination as! ProfileEditViewController
            vc.user = user
            vc.imageFile = profileImageView.file
        }
    }
}
