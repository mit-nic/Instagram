//
//  PhotoDetailsViewController.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/28/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var postImageView: PFImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var imageFile: PFFile?
    var user: String?
    var caption: String?
    
    weak var delegate: HomeTableViewCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImageView.file = imageFile
        postImageView.loadInBackground()
        userLabel.text = user!
        captionLabel.text = caption!

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
