//
//  HomeViewController.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var homeTableView: UITableView!
    
    var posts: [PFObject]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.dataSource = self
        homeTableView.delegate = self
        refresh()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        homeTableView.insertSubview(refreshControl, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        return posts!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        let post = posts![indexPath.row]
        cell.post = post
        return cell
    }
    
    func refresh() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.posts = objects
                self.homeTableView.reloadData()
            }
        }
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        refresh()
        refreshControl.endRefreshing()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailSegue" {
            let vc = segue.destination as! PhotoDetailsViewController
            let cell = sender as! HomeTableViewCell
            vc.imageFile = cell.postImageView.file
            vc.user = cell.userLabel.text
            vc.caption = cell.captionLabel.text
            vc.date = cell.createdDate
        }
    }
    
}


extension HomeViewController: HomeTableViewCellDelegate {
    func didSelectPhoto(homeTableViewCell: HomeTableViewCell) {
        performSegue(withIdentifier: "detailSegue", sender: homeTableViewCell)
    }
    
    func didSelectUser(homeTableViewCell: HomeTableViewCell) {
    }
}



