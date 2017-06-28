//
//  HomeViewController.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var posts: [PFObject]? = []
    var cell: HomeTableViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        refresh()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOutPress(_ sender: Any) {
        PFUser.logOutInBackground { (error:Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User logged out")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts!.count //number of posts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
        let post = posts![indexPath.row]
        let user = post["author"] as? PFUser
        let image = post["media"] as? PFFile
        if let image = image {
            image.getDataInBackground(block: { (imageData:Data?, error:Error?) in
                if error == nil {
                    let newImage = UIImage(data: imageData!)
                    self.cell?.postImageView.image = newImage
                }
            })
        }
        cell!.userCaptionLabel.text = user?.username
        cell!.captionLabel.text = post["caption"] as! String
        cell!.userLabel.text = user?.username
//        cell.postImageView.image = cellImage!
        
        return cell!
    }
    
    func refresh() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.includeKey("media")
        query.includeKey("caption")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.posts = objects
                self.homeTableView.reloadData()
            }
        }
        
    }
}

