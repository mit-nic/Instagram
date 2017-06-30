//
//  ProfileEditViewController.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/29/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ProfileEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var profileImageView: PFImageView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var user: PFUser?
    var imageFile: PFFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        
        if let imageFile = imageFile {
            profileImageView.file = imageFile
            profileImageView.loadInBackground()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changePhotoPress(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        profileImageView.image = editedImage
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveChanges(_ sender: Any) {
        user!["bio"] = descriptionTextField.text
        user!["picture"] = Post.getPFFileFromImage(image:profileImageView.image)
        
        user!.saveInBackground()
        dismiss(animated: true, completion: nil)
    }
}
