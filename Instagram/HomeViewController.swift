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
        // Do any additional setup after loading the view.
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        homeTableView.insertSubview(refreshControl, at: 0)
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
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let post = posts![indexPath.row]
        cell.post = post
        return cell
    }
    
    func refresh() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.includeKey("media")
        query.includeKey("caption")
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
        if type(of: segue.destination) != UINavigationController.self {
            let vc = segue.destination as! PhotoDetailsViewController
            let cell = sender as! HomeTableViewCell
            print(vc.postImageView)
            print(cell.postImageView.file)
            vc.postImageView = cell.postImageView.file
            vc.postImageView.loadInBackground()
            vc.userLabel.text = cell.userLabel.text
            vc.captionLabel.text = cell.captionLabel.text
        }
    }
    
}

