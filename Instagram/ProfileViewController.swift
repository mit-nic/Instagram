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

class ProfileViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var user: PFUser = PFUser.current()!
    var posts: [PFObject]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileCollectionView.dataSource = self
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
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.refresh), userInfo: nil, repeats: false)

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
                self.profileCollectionView.reloadData()
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = profileCollectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let post = posts![indexPath.row]
        cell.delegate = self
        cell.post = post
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editSegue" {
            let vc = segue.destination as! ProfileEditViewController
            vc.user = user
            vc.imageFile = profileImageView.file
        }
        
        if segue.identifier == "profileDetailSegue" {
            let vc = segue.destination as! PhotoDetailsViewController
            let cell = sender as! ProfileCollectionViewCell
            vc.user = user.username
            vc.caption = cell.caption
            vc.date = cell.createdDate
            vc.imageFile = cell.profilePostImageView.file
        }
    }
    
}

extension ProfileViewController: ProfileCollectionViewCellDelegate {
    func didSelectPhoto(profileCollectionViewCell: ProfileCollectionViewCell) {
        performSegue(withIdentifier: "profileDetailSegue", sender: profileCollectionViewCell)
    }
}
