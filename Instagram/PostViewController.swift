//
//  PostViewController.swift
//  Instagram
//
//  Created by Nicolas Rodriguez on 6/27/17.
//  Copyright © 2017 Nicolas Rodriguez. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage

        postImageView.image = editedImage
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func photoLibraryPress(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        self.present(vc, animated: true, completion: nil)
    }

    @IBAction func cameraPress(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            //raise error saying camera isn't available
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        Post.postUserImage(image: postImageView.image, withCaption: captionTextField.text) { (success: Bool, error: Error?) in
            if success {
                print("Post successful!")
                self.dismiss(animated: true, completion: nil)
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func cancelPress(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
